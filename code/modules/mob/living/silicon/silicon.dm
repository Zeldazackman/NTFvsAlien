/mob/living/silicon
	gender = NEUTER
	verb_say = "states"
	verb_ask = "queries"
	verb_exclaim = "declares"
	verb_yell = "alarms"
	speech_span = SPAN_ROBOT
	dextrous = TRUE

	initial_language_holder = /datum/language_holder/synthetic
	voice_filter = "afftfilt=real='hypot(re,im)*sin(0)':imag='hypot(re,im)*cos(0)':win_size=512:overlap=1,rubberband=pitch=0.8"

	var/obj/machinery/camera/builtInCamera = null
	var/obj/item/radio/headset/mainship/mcom/silicon/radio = null

	var/list/HUD_toggled = list(0, 0, 0)


/mob/living/silicon/Initialize(mapload)
	. = ..()
	GLOB.silicon_mobs += src
	radio = new(src)
	if(SStts.tts_enabled)
		voice = pick(SStts.available_speakers)


/mob/living/silicon/Destroy()
	QDEL_NULL(radio)
	GLOB.silicon_mobs -= src
	return ..()


/mob/living/silicon/drop_held_item()
	return


/mob/living/silicon/drop_all_held_items()
	return


/mob/living/silicon/get_held_item()
	return


/mob/living/silicon/get_inactive_held_item()
	return


/mob/living/silicon/get_active_held_item()
	return


/mob/living/silicon/put_in_l_hand(obj/item/I)
	return


/mob/living/silicon/put_in_r_hand(obj/item/I)
	return


/mob/living/silicon/stripPanelUnequip(obj/item/I, mob/M, slot)
	return


/mob/living/silicon/med_hud_set_health()
	return


/mob/living/silicon/med_hud_set_status()
	return


/mob/living/silicon/contents_explosion(severity)
	return ..()


/mob/living/silicon/emp_act(severity)
	. = ..()
	switch(severity)
		if(1)
			Stun(rand(10 SECONDS, 20 SECONDS))
			take_limb_damage(20)
		if(2)
			Stun(rand(2 SECONDS, 10 SECONDS))
			take_limb_damage(10)
	flash_act(1, TRUE, type = /atom/movable/screen/fullscreen/flash/noise)

	to_chat(src, span_danger("*BZZZT*"))
	to_chat(src, span_warning("Warning: Electromagnetic pulse detected."))

/mob/living/silicon/apply_effect(effect = 0, effect_type = EFFECT_STUN, updating_health = FALSE)
	return FALSE


/mob/living/silicon/adjustToxLoss(amount)
	return FALSE


/mob/living/silicon/setToxLoss(amount)
	return FALSE


/mob/living/silicon/adjustCloneLoss(amount)
	return FALSE


/mob/living/silicon/setCloneLoss(amount)
	return FALSE


/mob/living/silicon/adjustBrainLoss(amount)
	return FALSE


/mob/living/silicon/setBrainLoss(amount)
	return FALSE


//can't inject synths
/mob/living/silicon/can_inject(mob/user, error_msg, target_zone, penetrate_thick = FALSE)
	if(user && error_msg)
		to_chat(user, span_alert("The armoured plating is too tough."))
	return FALSE


/mob/living/silicon/proc/toggle_sensor_mode()
	if(!client)
		return
	var/list/listed_huds = list("Medical HUD", "Security HUD", "Squad HUD")
	var/hud_choice = tgui_input_list(src, "Choose a HUD to toggle", "Toggle HUD", listed_huds)
	if(!client)
		return
	var/datum/atom_hud/H
	var/HUD_nbr = 1
	switch(hud_choice)
		if("Medical HUD")
			H = GLOB.huds[DATA_HUD_MEDICAL_OBSERVER]
		if("Security HUD")
			H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
			HUD_nbr = 2
		if("Squad HUD")
			H = GLOB.faction_to_data_hud[faction]
			HUD_nbr = 3
		else
			return

	if(HUD_toggled[HUD_nbr])
		HUD_toggled[HUD_nbr] = 0
		H.remove_hud_from(src)
		to_chat(src, span_boldnotice("[hud_choice] Disabled"))
	else
		HUD_toggled[HUD_nbr] = 1
		H.add_hud_to(src)
		to_chat(src, span_boldnotice("[hud_choice] Enabled"))


/mob/living/silicon/ex_act(severity)
	flash_act()
	if(stat == DEAD)
		return
	switch(severity)
		if(EXPLODE_DEVASTATE)
			adjustBruteLoss(100)
			adjustFireLoss(100)
			if(!anchored)
				gib()
		if(EXPLODE_HEAVY)
			adjustBruteLoss(60)
			adjustFireLoss(60)
		if(EXPLODE_LIGHT)
			adjustBruteLoss(30)
		if(EXPLODE_WEAK)
			adjustBruteLoss(15)

	UPDATEHEALTH(src)


/mob/living/silicon/update_transform()
	var/matrix/ntransform = matrix(transform)
	var/changed = 0
	if(resize != RESIZE_DEFAULT_SIZE)
		changed++
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		animate(src, transform = ntransform, time = 2, easing = EASE_IN|EASE_OUT)
	return ..()


//ATTACK HAND IGNORING PARENT RETURN VALUE
/mob/living/silicon/attack_hand(mob/living/user)
	. = FALSE
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_HAND, user) & COMPONENT_NO_ATTACK_HAND)
		. = TRUE
	switch(user.a_intent)
		if(INTENT_HELP)
			user.visible_message("[user] pets [src].", span_notice("You pet [src]."))

		if(INTENT_GRAB)
			user.start_pulling(src)

		else
			user.do_attack_animation(src, ATTACK_EFFECT_KICK)
			playsound(loc, 'sound/effects/bang.ogg', 10, 1)
			visible_message(span_danger("[user] punches [src], but doesn't leave a dent."), \
				span_warning("[user] punches [src], but doesn't leave a dent."))
