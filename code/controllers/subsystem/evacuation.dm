SUBSYSTEM_DEF(evacuation)
	name = "Evacuation"
	flags = SS_NO_INIT|SS_TICKER

	var/list/pod_list = list()
	var/pod_cooldown
	var/evac_time
	var/evac_status = EVACUATION_STATUS_STANDING_BY
	///list of alarm lights that we activate during self destruct
	var/list/alarm_lights = list()

	var/obj/machinery/self_destruct/console/dest_master
	var/list/dest_rods
	var/dest_cooldown
	var/dest_index = 1
	var/dest_status = NUKE_EXPLOSION_INACTIVE

	var/scuttle_flags = FLAGS_SDEVAC_TIMELOCK
	///How many marines were on ship when the dropship crashed
	var/initial_human_on_ship = 0
	///How many marines escaped
	var/human_escaped = 0


/datum/controller/subsystem/evacuation/proc/prepare()
	dest_master = locate()
	if(!dest_master)
		stack_trace("SSevacuation: Could not find dest_master.")
		return FALSE
	dest_rods = list()
	for(var/obj/machinery/self_destruct/rod/I in dest_master.loc.loc)
		dest_rods += I
	if(!length(dest_rods))
		stack_trace("SSevacuation: Could not find any dest_rods.")
		qdel(dest_master)
		dest_master = null
		return FALSE

	dest_cooldown = SELF_DESTRUCT_ROD_STARTUP_TIME / length(dest_rods)
	dest_master.desc = "The main operating panel for a self-destruct system. It requires very little user input, but the final safety mechanism is manually unlocked.\nAfter the initial start-up sequence, [length(dest_rods)] control rods must be armed, followed by manually flipping the detonation switch."

/datum/controller/subsystem/evacuation/fire()
	process_evacuation()
	if(dest_status != NUKE_EXPLOSION_ACTIVE)
		return
	if(!dest_master.loc || dest_master.active_state != SELF_DESTRUCT_MACHINE_ARMED || dest_index > length(dest_rods))
		return

	var/obj/machinery/self_destruct/rod/I = dest_rods[dest_index]
	if(world.time < dest_cooldown + I.activate_time)
		return

	I.toggle()

	if(++dest_index > length(dest_rods))
		return

	I = dest_rods[dest_index]
	I.activate_time = world.time

///Deal with the escape pods, launching them when needed
/datum/controller/subsystem/evacuation/proc/process_evacuation()
	switch(evac_status)
		if(EVACUATION_STATUS_INITIATING)
			if(world.time < evac_time + EVACUATION_AUTOMATIC_DEPARTURE)
				return
			evac_status = EVACUATION_STATUS_IN_PROGRESS
		if(EVACUATION_STATUS_IN_PROGRESS)
			if(world.time < pod_cooldown + EVACUATION_POD_LAUNCH_COOLDOWN)
				return
			if(!length(pod_list)) // none left to pick from to evac
				if(!length(SSshuttle.escape_pods)) // no valid pods left, all have launched/exploded
					announce_evac_completion()
				return
			var/obj/docking_port/mobile/escape_pod/P = pick_n_take(pod_list)
			P.launch()



/datum/controller/subsystem/evacuation/proc/initiate_evacuation(override)
	if(evac_status != EVACUATION_STATUS_STANDING_BY)
		return FALSE
	if(!override && scuttle_flags & (FLAGS_EVACUATION_DENY|FLAGS_SDEVAC_TIMELOCK))
		return FALSE
	//GLOB.enter_allowed = FALSE
	evac_time = world.time
	evac_status = EVACUATION_STATUS_INITIATING
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_EVACUATION_STARTED)
	var/sec_level_changed = SSsecurity_level.set_level(SEC_LEVEL_DELTA, FALSE) // TRUE if we weren't already on Delta alert
	priority_announce(
		type = ANNOUNCEMENT_PRIORITY,
		title = "[sec_level_changed ? "Code Delta emergency declared. " : ""]Evacuation in [EVACUATION_AUTOMATIC_DEPARTURE/600] minutes.",
		message = "Emergency evacuation has been triggered. Please proceed to the escape pods.[sec_level_changed ? "\n\n[CONFIG_GET(string/alert_delta)]" : ""]",
		sound = 'sound/AI/evacuate.ogg',
		color_override = sec_level_changed ? "purple" : "orange"
	)
	xeno_message("A wave of adrenaline ripples through the hive. The fleshy creatures are trying to escape!")
	pod_list = SSshuttle.escape_pods.Copy()
	for(var/obj/docking_port/mobile/escape_pod/pod AS in pod_list)
		pod.prep_for_launch()
	return TRUE


/datum/controller/subsystem/evacuation/proc/begin_launch()
	if(evac_status != EVACUATION_STATUS_INITIATING)
		return FALSE
	evac_status = EVACUATION_STATUS_IN_PROGRESS
	priority_announce("WARNING: Evacuation order confirmed. Launching escape pods.", title = "Emergency Evacuation", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/evacuation_confirmed.ogg', color_override = "orange")
	return TRUE


/datum/controller/subsystem/evacuation/proc/cancel_evacuation()
	if(evac_status != EVACUATION_STATUS_INITIATING)
		return FALSE
	//GLOB.enter_allowed = TRUE
	evac_time = null
	evac_status = EVACUATION_STATUS_STANDING_BY
	priority_announce("Evacuation has been cancelled.", title = "Emergency Evacuation", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/evacuate_cancelled.ogg', color_override = "orange")
	for(var/obj/docking_port/mobile/escape_pod/pod AS in pod_list)
		pod.unprep_for_launch()
	return TRUE


/datum/controller/subsystem/evacuation/proc/get_status_panel_eta()
	switch(evac_status)
		if(EVACUATION_STATUS_INITIATING)
			var/eta = EVACUATION_ESTIMATE_DEPARTURE
			. = "[(eta / 60) % 60]:[add_leading(num2text(eta % 60), 2, "0")]"
		if(EVACUATION_STATUS_IN_PROGRESS)
			. = "NOW"

/datum/controller/subsystem/evacuation/proc/announce_evac_completion()
	priority_announce("ATTENTION: Evacuation complete.", title = "Emergency Evacuation", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/evacuation_complete.ogg', color_override = "orange")
	evac_status = EVACUATION_STATUS_COMPLETE


/datum/controller/subsystem/evacuation/proc/enable_self_destruct(override)
	if(dest_status != NUKE_EXPLOSION_INACTIVE)
		return FALSE
	if(!override && scuttle_flags & (FLAGS_SELF_DESTRUCT_DENY|FLAGS_SDEVAC_TIMELOCK))
		return FALSE
	dest_status = NUKE_EXPLOSION_ACTIVE
	dest_master.toggle()
	SSsecurity_level.set_level(SEC_LEVEL_DELTA)
	for(var/obj/machinery/floor_warn_light/toggleable/self_destruct/light AS in alarm_lights)
		light.enable()
	return TRUE


/datum/controller/subsystem/evacuation/proc/cancel_self_destruct(override)
	if(dest_status != NUKE_EXPLOSION_ACTIVE)
		return FALSE
	var/obj/machinery/self_destruct/rod/I
	var/i
	for(i in SSevacuation.dest_rods)
		I = i
		if(I.active_state == SELF_DESTRUCT_MACHINE_ARMED && !override)
			dest_master.visible_message(span_warning("WARNING: Unable to cancel detonation. Please disarm all control rods."))
			return FALSE

	dest_status = NUKE_EXPLOSION_INACTIVE
	for(i in dest_rods)
		I = i
		if(I.active_state == SELF_DESTRUCT_MACHINE_ACTIVE || (I.active_state == SELF_DESTRUCT_MACHINE_ARMED && override))
			I.toggle(TRUE)
	dest_master.toggle(TRUE)
	dest_index = 1
	priority_announce("The emergency destruct system has been deactivated.", title = "Self Destruct System", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/selfdestruct_deactivated.ogg', color_override = "purple")
	if(evac_status == EVACUATION_STATUS_STANDING_BY)
		SSsecurity_level.set_level(SEC_LEVEL_RED, TRUE)
	for(var/obj/machinery/floor_warn_light/toggleable/self_destruct/light AS in alarm_lights)
		light.disable()
	return TRUE


/datum/controller/subsystem/evacuation/proc/initiate_self_destruct(override)
	if(dest_status >= NUKE_EXPLOSION_IN_PROGRESS)
		return FALSE

	var/obj/machinery/self_destruct/rod/I
	for(var/i in dest_rods)
		I = i
		if(I.active_state != SELF_DESTRUCT_MACHINE_ARMED && !override)
			dest_master.visible_message(span_warning("WARNING: Unable to trigger detonation. Please arm all control rods."))
			return FALSE

	priority_announce("DANGER. DANGER. Self destruct system activated. DANGER. DANGER. Self destruct in progress. DANGER. DANGER.", title = "Self Destruct System", type = ANNOUNCEMENT_PRIORITY, color_override = "purple")
	//GLOB.enter_allowed = FALSE
	dest_status = NUKE_EXPLOSION_IN_PROGRESS
	playsound(dest_master, 'sound/machines/alarm.ogg', 75, 0, 30)
	var/sound/S = sound(pick('sound/theme/nuclear_detonation1.ogg','sound/theme/nuclear_detonation2.ogg'), channel = CHANNEL_CINEMATIC)
	SEND_SOUND(world, S)

	var/list/z_levels = list(SSmapping.levels_by_trait(ZTRAIT_MARINE_MAIN_SHIP))
	var/ship_intact = FALSE

	var/f = SSmapping.levels_by_trait(ZTRAIT_MARINE_MAIN_SHIP)
	if(f in z_levels)
		ship_intact = TRUE

	for(var/x in GLOB.player_list)
		var/mob/M = x
		if(isobserver(M))
			continue
		if(M.z == I.z)
			shake_camera(M, 110, 4)

	if(ship_intact)
		Cinematic(CINEMATIC_SELFDESTRUCT_MISS, world)
	else
		Cinematic(CINEMATIC_SELFDESTRUCT, world)

	dest_status = NUKE_EXPLOSION_FINISHED


/datum/controller/subsystem/evacuation/proc/get_affected_zlevels()
	if(dest_status >= NUKE_EXPLOSION_IN_PROGRESS || evac_status != EVACUATION_STATUS_COMPLETE)
		return
	. = SSmapping.levels_by_any_trait(list(ZTRAIT_MARINE_MAIN_SHIP))
