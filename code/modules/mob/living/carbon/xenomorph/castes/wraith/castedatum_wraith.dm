/datum/xeno_caste/wraith
	caste_name = "Wraith"
	display_name = "Wraith"
	upgrade_name = ""
	caste_desc = "A strange xeno that utilizes its psychic powers to move out of phase with reality."
	base_strain_type = /mob/living/carbon/xenomorph/wraith
	caste_type_path = /mob/living/carbon/xenomorph/wraith
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "wraith" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 24

	// *** Speed *** //
	speed = -1.1

	// *** Plasma *** //
	plasma_max = 200
	plasma_gain = 35

	// *** Health *** //
	max_health = 340

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/xeno_caste/hunter

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = parent_type::can_flags|CASTE_CAN_BE_GIVEN_PLASMA
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 0, BIO = 20, FIRE = 30, ACID = 20)

	// *** Minimap Icon *** //
	minimap_icon = "wraith"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_whisper,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/blink,
		/datum/action/ability/activable/xeno/banish,
		/datum/action/ability/xeno_action/recall,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/rewind,
		/datum/action/ability/xeno_action/portal,
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)

/datum/xeno_caste/wraith/normal
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/wraith/primordial
	upgrade_name = "Primordial"
	caste_desc = "A xenomorph that has perfected the manipulation of space and time. Its movements appear quick and distorted."
	primordial_message = "Mastery is achieved when \'telling time\' becomes \'telling time what to do\'."
	upgrade = XENO_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_whisper,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/blink,
		/datum/action/ability/activable/xeno/banish,
		/datum/action/ability/xeno_action/recall,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/rewind,
		/datum/action/ability/xeno_action/portal,
		/datum/action/ability/xeno_action/timestop,
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)
