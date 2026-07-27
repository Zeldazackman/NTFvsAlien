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

//NT-VORTEX

/obj/item/weapon/gun/smg/vortex
	name = "\improper NT Vortex rapid-fire EM SMG"
	desc = "The Ninetails Vortex electromagnetic submachinegun is the specialized weapon made by commission for Novamed Trauma Teams, calibered in 9x19mm Parabellum but it uses special rounds without a primer or anything for it's electromagnetic operation. Made to be used by hospital security and combat medics. Though much like other new-world design weapons, this lacks fire-modes and it is always on full-auto. - With it's foldable design, it is easily carried around in satchels until need arises. It is designed in such a way it retains great accuracy in rapid fire but the accuracy quickly decays on sustained fire and must be rested a little while to let heatsinks do it's work, and since it is firing electromagnetically, it does not have muzzle flash or much sound... But it is rather muzzle attachment-unfriendly due to being packable. Use Unique action key to deploy/undeploy it."
	icon_state = "vortex"
	icon = 'ntf_modular/icons/obj/items/guns/submachineguns64.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/submachineguns_left_1.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/submachineguns_right_1.dmi',
	)
	worn_icon_state = "vortex"
	caliber = CALIBER_9X19
	max_shells = 60
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
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
	)

	starting_attachment_types = list(/obj/item/attachable/suppressor/unremovable/invisible)

	attachable_offset = list("muzzle_x" = 38, "muzzle_y" = 20,"rail_x" = 28, "rail_y" = 22, "under_x" = 31, "under_y" = 15, "stock_x" = 24, "stock_y" = 10)

	fire_delay = 0.1 SECONDS
	aim_slowdown = 0.15
	wield_delay = 0.3 SECONDS

	accuracy_mult = 1.15
	accuracy_mult_unwielded = 0.75

	recoil = 0
	recoil_unwielded = 4.5

	scatter = -1 //gets progressively worse while shot, also angled grip included
	scatter_unwielded = 8
	aim_speed_modifier = 5.8
	min_scatter_unwielded = 8
	scatter_increase = 0.5
	scatter_increase_unwielded = 0.5
	scatter_decay = 3
	scatter_decay_unwielded = 3
	min_scatter = -1
	movement_acc_penalty_mult = 4

	akimbo_additional_delay = 0.7
	var/extended = FALSE

/obj/item/weapon/gun/smg/vortex/unique_action(mob/living/user)
	if(!do_after(user, 10, TRUE, src, BUSY_ICON_DANGER))
		return
	playsound(user, 'sound/weapons/guns/interact/m41a_unload.ogg', 25, 1)
	extended = !extended
	if(!extended)
		w_class = WEIGHT_CLASS_NORMAL
		gun_features_flags |= GUN_DEPLOYED_FIRE_ONLY
	else
		w_class = WEIGHT_CLASS_BULKY
		gun_features_flags &= ~GUN_DEPLOYED_FIRE_ONLY
	update_icon()


/obj/item/weapon/gun/smg/vortex/update_icon_state()
	. = ..()
	if(extended)
		icon_state = "[base_gun_icon]_dep"
	else
		icon_state = base_gun_icon

/obj/item/weapon/gun/smg/vortex/update_item_state()
	var/current_state = worn_icon_state

	worn_icon_state = "[base_gun_icon][extended ? "_dep" : ""][item_flags & WIELDED ? "_w" : ""]"

	if(current_state != worn_icon_state && ishuman(gun_user))
		var/mob/living/carbon/human/human_user = gun_user
		if(src == human_user.l_hand)
			human_user.update_inv_l_hand()
		else if (src == human_user.r_hand)
			human_user.update_inv_r_hand()


/obj/item/ammo_magazine/smg/vortex
	name = "\improper NT Vortex SMG magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum SMG magazine."
	caliber = CALIBER_9X19
	icon_state = "v21"
	icon_state_mini = "mag_smg"
	max_rounds = 60
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_magazine/smg/vortex/ap
	name = "\improper NT Vortex AP SMG magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum SMG magazine, loaded in armor piercing rounds."
	icon_state = "v21_ap"
	default_ammo = /datum/ammo/bullet/smg/ap
	icon_state_mini = "mag_smg_green"

/obj/item/ammo_magazine/smg/vortex/squashhead
	name = "\improper NT Vortex squash-head SMG magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless SMG magazine, loaded in squash-head explosive rounds. Will shred the armor off of basically anything."
	icon_state = "v21_ap"
	default_ammo = /datum/ammo/bullet/smg/squash
	icon_state_mini = "mag_smg_green"

/obj/item/ammo_magazine/smg/vortex/rubber
	name = "\improper NT Vortex rubber SMG magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless SMG magazine, loaded in rubber rounds. Non-lethal."
	default_ammo = /datum/ammo/bullet/smg/rubber

/obj/item/ammo_magazine/smg/vortex/incendiary
	name = "\improper NT Vortex incendiary SMG magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless SMG magazine, loaded in incendiary rounds."
	icon_state = "v21_incend"
	default_ammo = /datum/ammo/bullet/smg/incendiary
	icon_state_mini = "mag_smg_red"

/obj/item/ammo_magazine/smg/vortex/extended
	name = "\improper NT Vortex extended SMG magazine (9x19mm Parabellum)"
	desc = "An extended 9x19mm Parabellum caseless SMG magazine."
	icon_state = "v21_extended"
	max_rounds = 90
	icon_state_mini = "mag_smg_yellow"
	w_class = WEIGHT_CLASS_NORMAL
	aim_speed_mod = 0.1

/obj/item/ammo_magazine/smg/vortex/rad
	name = "\improper NT Vortex radioactive SMG magazine (9x19mm Parabellum)"
	desc = "A 9x19mm Parabellum caseless SMG magazine, loaded with radioactive rounds. Handle with care."
	icon_state = "v21_rad"
	default_ammo = /datum/ammo/bullet/smg/rad
	icon_state_mini = "mag_smg_greenyellow"
