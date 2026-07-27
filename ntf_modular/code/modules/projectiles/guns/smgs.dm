//MINI-B 9MM //Based on the Minebea PM-9

/obj/item/weapon/gun/smg/minib
	name = "\improper MINI-B machinepistol"
	desc = "A niche classic refurbished and improved by Kaizoku Zaibatsu for bodyguards and field adjutants, the MINI-B is a take on the SMG-2 platform and uses specialized highpowered 9MM armor piercing munitions."
	icon = 'ntf_modular/icons/obj/items/guns/submachineguns.dmi'
	worn_icon_state = "minib"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/submachineguns_left_1.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/submachineguns_right_1.dmi',
	)
	icon_state = "minib"
	caliber = CALIBER_9X19 //codex
	max_shells = 25 //codex
	w_class = WEIGHT_CLASS_NORMAL
	fire_sound = 'sound/weapons/guns/fire/uzi.ogg'
	unload_sound = 'sound/weapons/guns/interact/uzi_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/uzi_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/uzi_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/smg/minib
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/minib, /obj/item/ammo_magazine/smg/minib/extended)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
	)
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 23,"rail_x" = 11, "rail_y" = 27, "under_x" = 22, "under_y" = 18, "stock_x" = 22, "stock_y" = 16)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.15 SECONDS
	aim_speed_modifier = 0.75
	fire_delay = 0.1 SECONDS
	burst_delay =  0.15 SECONDS
	burst_amount = 5
	accuracy_mult = 0.7
	accuracy_mult_unwielded = 0.5
	scatter = 6
	scatter_unwielded = 12
	aim_slowdown = 0.15
	wield_delay = 0.4 SECONDS
	damage_mult = 1

/obj/item/weapon/gun/smg/minib/kzescort
	default_ammo_type = /obj/item/ammo_magazine/smg/minib/extended
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/gyro, /obj/item/attachable/suppressor,)

/obj/item/ammo_magazine/smg/minib
	name = "\improper MB9 magazine (9mm)"
	desc = "A magazine for the MINI-B machinepistol."
	caliber = CALIBER_9X19
	icon = 'ntf_modular/icons/obj/items/ammo/submachinegun.dmi'
	icon_state = "minib"
	icon_state_mini = "mag_smg_dark"
	max_rounds = 25
	default_ammo = /datum/ammo/bullet/smg/minibap

/obj/item/ammo_magazine/smg/minib/extended
	name = "\improper MB9 extended magazine (9mm)"
	desc = "An extended magazine for the MINI-B machinepistol."
	icon_state = "minib_ext"
	max_rounds = 42
	w_class = WEIGHT_CLASS_SMALL
	bonus_overlay = "minib_ext"
	icon_state_mini = "mag_smg_dark"

/datum/ammo/bullet/smg/minibap
	name = "specialized armor-piercing machinepistol bullet"
	hud_state = "smg_ap"
	damage = 15
	accurate_range = 5
	sundering = 0.6
	penetration = 10

//NM-VORTEX

/obj/item/weapon/gun/smg/vortex
	name = "\improper NT Vortex rapid-fire EM SMG"
	desc = "The Ninetails Vortex electromagnetic submachinegun is the specialized weapon made by commission for Novamed Trauma Teams, calibered in 9x19mm Parabellum but it uses special rounds without a primer or anything for it's electromagnetic operation. Made to be used by hospital security and combat medics. Though much like other new-world design weapons, this lacks fire-modes and it is always on full-auto. - With it's foldable design, it is easily carried around in satchels until need arises. It is designed in such a way it retains it's accuracy in rapid fire, and since it is firing electromagnetically, it does not have muzzle flash or much sound... But it is rather attachment-unfriendly due to being packable."
	icon_state = "vortex"
	icon = 'ntf_modular/icons/obj/items/guns/submachineguns.dmi'
	worn_icon_state = "vortex"
	caliber = CALIBER_9X19
	max_shells = 50
	w_class = WEIGHT_CLASS_NORMAL
	equip_slot_flags = ITEM_SLOT_BACK
	type_of_casings = null
	muzzle_flash = null
	fire_sound = SFX_GUN_SILENCED
	default_ammo_type = /obj/item/ammo_magazine/smg/vortex
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/smg/vortex,
		/obj/item/ammo_magazine/smg/vortex/rubber,
		/obj/item/ammo_magazine/smg/vortex/ap,
		/obj/item/ammo_magazine/smg/vortex/incendiary,
		/obj/item/ammo_magazine/smg/vortex/extended,
		/obj/item/ammo_magazine/smg/vortex/rad,
		/obj/item/ammo_magazine/smg/vortex/squashhead,
	)
	fire_sound = 'sound/weapons/guns/fire/vector_fire.ogg'
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/foldable/vortex_stock,
	)

	starting_attachment_types = list(/obj/item/attachable/foldable/vortex_stock, /obj/item/attachable/suppressor/unremovable/invisible)

	attachable_offset = list("muzzle_x" = 38, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 31, "under_y" = 15, "stock_x" = 24, "stock_y" = 10)

	fire_delay = 0.1 SECONDS
	aim_slowdown = 0.15
	wield_delay = 0.3 SECONDS

	accuracy_mult = 0.9
	accuracy_mult_unwielded = 0.7

	recoil = 18
	recoil_unwielded = 2.5

	scatter = 8
	scatter_unwielded = 16

	akimbo_additional_delay = 0.7

/obj/item/attachable/foldable/vortex
	name = "\improper NT Vortex deploy button"
	desc = "button for the full-deployment of NT Vortex, as it cant really be shot without being deployed. The gun is designed to be fired while unfolded, though you can force it to fire.... you will likely not have a good time,"
	attach_features_flags = ATTACH_ACTIVATION
	wield_delay_mod = 0.1 SECONDS
	icon_state = ""
	melee_mod = 5
	size_mod = 1
	accuracy_mod = 0.2
	accuracy_unwielded_mod = 0.2
	recoil_mod = -18
	recoil_unwielded_mod = -18
	scatter_mod = -4
	movement_acc_penalty_mod = -1

/obj/item/attachable/foldable/vortex/activate(mob/living/user, turn_off)
	. = ..()
	master_gun.icon_state = "[initial(icon_state)][folded ? "": "_dep"]"

/obj/item/ammo_magazine/smg/vortex
	name = "\improper NT Vortex submachinegun magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum submachinegun magazine."
	caliber = CALIBER_10X20_CASELESS
	icon_state = "v21"
	icon_state_mini = "mag_smg"
	max_rounds = 60
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_magazine/smg/vortex/ap
	name = "\improper NT Vortex AP submachinegun magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum submachinegun magazine, loaded in armor piercing rounds."
	icon_state = "v21_ap"
	default_ammo = /datum/ammo/bullet/smg/ap
	icon_state_mini = "mag_smg_green"

/obj/item/ammo_magazine/smg/vortex/squashhead
	name = "\improper NT Vortex squash-head submachinegun magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless submachinegun magazine, loaded in squash-head explosive rounds. Will shred the armor off of basically anything."
	icon_state = "v21_ap"
	default_ammo = /datum/ammo/bullet/smg/squash
	icon_state_mini = "mag_smg_green"

/obj/item/ammo_magazine/smg/vortex/rubber
	name = "\improper NT Vortex rubber submachinegun magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless submachinegun magazine, loaded in rubber rounds. Non-lethal."
	default_ammo = /datum/ammo/bullet/smg/rubber

/obj/item/ammo_magazine/smg/vortex/incendiary
	name = "\improper NT Vortex incendiary submachinegun magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless submachinegun magazine, loaded in incendiary rounds."
	icon_state = "v21_incend"
	default_ammo = /datum/ammo/bullet/smg/incendiary
	icon_state_mini = "mag_smg_red"

/obj/item/ammo_magazine/smg/vortex/extended
	name = "\improper NT Vortex extended submachinegun magazine (9x19mm Parabellum)"
	desc = "An extended 9x19mm Parabellum caseless submachinegun magazine."
	icon_state = "v21_extended"
	max_rounds = 90
	icon_state_mini = "mag_smg_yellow"
	w_class = WEIGHT_CLASS_NORMAL
	aim_speed_mod = 0.1

/obj/item/ammo_magazine/smg/vortex/rad
	name = "\improper NT Vortex radioactive submachinegun magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless submachinegun magazine, loaded with radioactive rounds. Handle with care."
	icon_state = "v21_rad"
	default_ammo = /datum/ammo/bullet/smg/rad
	icon_state_mini = "mag_smg_greenyellow"
