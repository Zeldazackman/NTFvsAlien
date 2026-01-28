/datum/mutation_upgrade/shell/lone_lurker
	name = "Lone Lurker"
	desc = "You will gain the ability to regenerate health, sunder and plasma off weeds as if on weeds but your benefit from pheromones is reduced to 0.5x/0.7x/0.9x."
	/// For the first structure, what will our phero effectiveness reduction be
	var/multiplier_initial = 0.7
	/// For each structure
	var/multiplier_per_structure = -0.2

/datum/mutation_upgrade/shell/lone_lurker/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return "You will gain the ability to regenerate health, sunder and plasma off weeds as if on weeds but your benefit from pheromones is reduced to [get_multiplier(new_amount)]x"

/datum/mutation_upgrade/shell/lone_lurker/on_mutation_enabled()
	. = ..()
	xenomorph_owner.phero_efficency_mult -= get_multiplier(0)
	xenomorph_owner.weedless_regen = TRUE

/datum/mutation_upgrade/shell/lone_lurker/on_mutation_disabled()
	. = ..()
	xenomorph_owner.phero_efficency_mult += get_multiplier(0)
	xenomorph_owner.weedless_regen = initial(xenomorph_owner.weedless_regen)

/datum/mutation_upgrade/shell/lone_lurker/on_structure_update(previous_amount, new_amount)
	. = ..()
	xenomorph_owner.phero_efficency_mult -= get_multiplier(new_amount - previous_amount, FALSE)

/datum/mutation_upgrade/shell/lone_lurker/proc/get_multiplier(structure_count, include_initial = TRUE)
	return (include_initial ? multiplier_initial : 0) + (multiplier_per_structure * structure_count)


//*********************//
//         Spur        //
//*********************//

//mostly reflavor
/datum/mutation_upgrade/spur/ambush/assassin
	name = "Execution"
	desc = "Phase Out's duration is decreased by 3 seconds. Your next sneak attack has an additional 15/22.5/30 AP."

/datum/mutation_upgrade/spur/ambush/assassin/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return  "Phase Out's duration is decreased by 3 seconds. Your next sneak attack has an additional [get_ap(new_amount)] AP."

/datum/mutation_upgrade/spur/maul/assassin
	name = "Leaper"
	desc = "Lunge's cooldown is set to 60/50/40% of its original value."

//*********************//
//         Veil        //
//*********************//
/datum/mutation_upgrade/veil/death_trail
	name = "Death Trail"
	desc = "The duration of your Death Mark increases by 1.50x/1.75x/2x and bonus sneak attack damage of it is increased to 2.5x/2.75x/3x"
	var/multiplier_initial = 2.25
	var/initial_duration_mult = 1.25
	var/multiplier_per_structure = 0.25

/datum/mutation_upgrade/veil/death_trail/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return "he duration of your Death Mark increases by [[get_duration_multiplier(new_amount)]] and bonus sneak attack damage of it is increased to [get_multiplier(new_amount)]x"

/datum/mutation_upgrade/veil/death_trail/on_mutation_enabled()
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.death_mark_multiplier += get_duration_multiplier(0)
	dm_ability.death_mark_damage_multiplier += get_multiplier(0)

/datum/mutation_upgrade/veil/death_trail/on_mutation_disabled()
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.death_mark_multiplier -= get_duration_multiplier(0)
	dm_ability.death_mark_damage_multiplier -= get_multiplier(0)

/datum/mutation_upgrade/veil/death_trail/on_structure_update(previous_amount, new_amount)
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.death_mark_multiplier += get_duration_multiplier(new_amount - previous_amount, FALSE)
	dm_ability.death_mark_damage_multiplier += get_multiplier(new_amount - previous_amount, FALSE)

/datum/mutation_upgrade/veil/death_trail/proc/get_multiplier(structure_count, include_initial = TRUE)
	return (include_initial ? multiplier_initial : 0) + (multiplier_per_structure * structure_count)

/datum/mutation_upgrade/veil/death_trail/proc/get_duration_multiplier(structure_count, include_initial = TRUE)
	return (include_initial ? initial_duration_mult : 0) + (multiplier_per_structure * structure_count)
