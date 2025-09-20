/datum/action/ability/xeno_action/place_acidwell/neuro
	name = "Place neuro well"
	action_icon_state = "place_trap"
	action_icon = 'icons/Xeno/actions/construction.dmi' //would be neat to have a separate icon.  Should go in 'ntf_modular/icons/Xeno/actions/construction.dmi' if created.
	desc = "Place a neurotoxin well that can put out fires and deter intruders with gas."
	ability_cost = 400
	cooldown_duration = 2 MINUTES //would be neat to make this share a cooldown with acid wells
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PLACE_ACID_WELL, //would be neat to have a separate keybinding
	)

/datum/action/ability/xeno_action/place_acidwell/neuro/action_activate()
	var/turf/T = get_turf(owner)
	succeed_activate()

	playsound(T, SFX_ALIEN_RESIN_BUILD, 25)
	new /obj/structure/xeno/acidwell/neuro(T, xeno_owner.hivenumber, owner)

	to_chat(owner, span_xenonotice("We place a neuro well; it can be filled with more neurotoxin."))
	GLOB.round_statistics.xeno_acid_wells++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "xeno_acid_wells")
	owner.record_traps_created()

/datum/action/ability/xeno_action/place_acidwell/aphro
	name = "Place aphro well"
	action_icon_state = "place_trap"
	action_icon = 'icons/Xeno/actions/construction.dmi' //would be neat to have a separate icon.  Should go in 'ntf_modular/icons/Xeno/actions/construction.dmi' if created.
	desc = "Place an aphrotoxin well that can put out fires and distract intruders with gas."
	ability_cost = 400
	cooldown_duration = 2 MINUTES //would be neat to make this share a cooldown with acid wells
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PLACE_ACID_WELL, //would be neat to have a separate keybinding
	)

/datum/action/ability/xeno_action/place_acidwell/aphro/action_activate()
	var/turf/T = get_turf(owner)
	succeed_activate()

	playsound(T, SFX_ALIEN_RESIN_BUILD, 25)
	new /obj/structure/xeno/acidwell/aphro(T, xeno_owner.hivenumber, owner)

	to_chat(owner, span_xenonotice("We place an aphro well; it can be filled with more aphrotoxin."))
	GLOB.round_statistics.xeno_acid_wells++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "xeno_acid_wells")
	owner.record_traps_created()
