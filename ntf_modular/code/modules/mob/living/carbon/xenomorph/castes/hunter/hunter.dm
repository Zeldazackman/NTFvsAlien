/mob/living/carbon/xenomorph/hunter/assassin
	icon_state = "Assassin Hunter Running"
	caste_base_type = /datum/xeno_caste/hunter/assassin
	var/disp_warning_cd

/mob/living/carbon/xenomorph/hunter/assassin/Life(seconds_per_tick, times_fired)
	. = ..()
	if(status_flags & INCORPOREAL)
		if(!loc_weeds_type)
			use_plasma(4, TRUE)
		if(plasma_stored < plasma_stored/2 && COOLDOWN_FINISHED(src, disp_warning_cd))
			TIMER_COOLDOWN_START(src, disp_warning_cd, 10 SECONDS)
			SEND_SOUND(src, sound('sound/voice/alien/help1.ogg', volume = 15))
			to_chat(src, span_xenodanger("We are running low on plasma, we must get out of displacement or we will die soon!"))
			if(plasma_stored <= 0)
				var/datum/action/ability/xeno_action/displacement/displacement = actions_by_path[/datum/action/ability/xeno_action/displacement]
				displacement.do_change_form(src)
				emote("roar3")
				death(TRUE)

/mob/living/carbon/xenomorph/hunter/assassin/death(gibbing, deathmessage, silent)
	if(status_flags & INCORPOREAL)
		var/datum/action/ability/xeno_action/displacement/displacement = actions_by_path[/datum/action/ability/xeno_action/displacement]
		displacement.do_change_form(src)
		death(FALSE)
	. = ..()
