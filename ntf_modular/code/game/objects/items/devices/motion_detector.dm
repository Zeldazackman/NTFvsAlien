/obj/item/attachable/motiondetector/advanced
	name = "AC-2 tactical motion tracker"
	desc = "A massive upgrade to the usual motion detector, With buckles to be belt-worn and higher range, the tactical motion sensor allows better tracking of hostile threats through also transmitting findings to faction map."
	icon = 'ntf_modular/icons/obj/items/cm_items.dmi'
	icon_state = "detector"
	worn_icon_state = "motion_detector"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/equipment/tools_lefthand.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/equipment/tools_righthand.dmi',
	)
	range = 24
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_NORMAL
	var/ping_count = 0
	var/ping_overlay

/obj/item/attachable/motiondetector/advanced/pocket
	name = "AC-2M pocket tactical motion tracker"
	desc = "A smaller version of the AC-2 that would fit a pocket but is lesser in range, similiar to standard motion trackers."
	icon = 'ntf_modular/icons/obj/items/cm_items.dmi'
	icon_state = "pocket"
	range = 16
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE|ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_SMALL

/obj/item/attachable/motiondetector/advanced/process()
	if(!operator?.client || operator.stat != CONSCIOUS)
		clean_operator()
		return
	ping_count = 0
	hostile_detected = FALSE
	for (var/mob/living/carbon/human/nearby_human AS in cheap_get_humans_near(operator, range))
		if(nearby_human == operator)
			continue
		if(nearby_human.last_move_time + move_sensitivity < world.time)
			continue
		if(!(nearby_human.get_iff_signal() & operator.get_iff_signal()))
			ping_count++
		prepare_blip(nearby_human, nearby_human.wear_id?.iff_signal & operator.get_iff_signal() ? MOTION_DETECTOR_FRIENDLY : MOTION_DETECTOR_HOSTILE)
	for (var/mob/living/carbon/xenomorph/nearby_xeno AS in cheap_get_xenos_near(operator, range))
		if(nearby_xeno.last_move_time + move_sensitivity < world.time )
			continue
		if(!(nearby_xeno.get_iff_signal() & operator.get_iff_signal()))
			ping_count++
		prepare_blip(nearby_xeno, nearby_xeno.get_iff_signal() & operator.get_iff_signal() ?  MOTION_DETECTOR_FRIENDLY : MOTION_DETECTOR_HOSTILE)
	if(ping_count)
		//playsound(loc, 'sound/items/tick.ogg', 100, 0, 7, 2)
		playsound(loc, pick('ntf_modular/sound/items/detector_ping_1.ogg', 'ntf_modular/sound/items/detector_ping_2.ogg', 'ntf_modular/sound/items/detector_ping_3.ogg', 'ntf_modular/sound/items/detector_ping_4.ogg'), 60, 0, 7, 2)
	else
		playsound(loc, 'ntf_modular/sound/items/detector.ogg', 60, 0, 7, 2)

	update_icon_state()
	new /obj/effect/temp_visual/minimap_pulse(get_turf(operator.loc), GLOB.faction_to_minimap_flag[operator.faction], range)
	addtimer(CALLBACK(src, PROC_REF(clean_blips)), 1 SECONDS)

/obj/item/attachable/motiondetector/advanced/prepare_blip(mob/target, status)
	. = ..()
	new /obj/effect/temp_visual/minimap_blip(get_turf(target), GLOB.faction_to_minimap_flag[operator.faction])

/obj/item/attachable/motiondetector/advanced/update_icon_state()
	. = ..()
	if(overlays)
		overlays.Cut()
	else
		overlays = list()
	if(ping_count > 8)
		ping_overlay = "+[icon_state]_9"
	else
		ping_overlay = "+[icon_state]_[ping_count]"
	var/image/ping_overlay_image = ping_overlay
	if(!isnull(operator))
		overlays += ping_overlay_image

/obj/effect/temp_visual/minimap_pulse
	icon = null
	duration = 0.75 SECONDS

/obj/effect/temp_visual/minimap_pulse/Initialize(mapload, minimap_flag = MINIMAP_FLAG_ALL, range)
	. = ..()
	var/pulse_icon
	if(range > 16)
		pulse_icon = "motion_long_pulses_noloop"
	else
		pulse_icon = "motion_short_pulses_noloop"
	SSminimaps.add_marker(src, minimap_flag, image('ntf_modular/icons/UI_icons/cm/map_blips_larger.dmi', null, pulse_icon, MINIMAP_BLIPS_LAYER_HIGH, SOUTH, -28.25, -28.2))

/obj/effect/temp_visual/minimap_blip
	icon = null
	duration = 1 SECONDS

/obj/effect/temp_visual/minimap_blip/Initialize(mapload, minimap_flags = MINIMAP_FLAG_ALL)
	. = ..()
	SSminimaps.add_marker(src, minimap_flags, image('ntf_modular/icons/UI_icons/cm/map_blips.dmi', null, "locator", MINIMAP_BLIPS_LAYER_EXTRA_HIGH))
