


/datum/interior/armored/logi
	template = /datum/map_template/interior/logi

/datum/map_template/interior/logi
	name = "transport truck interior template"
	filename = "logitruck"

/obj/vehicle/sealed/armored/multitile/mrap/logi
	name = "\improper TransCO 'Roadmaster' Logistics Truck"
	desc = "A lightly armored logistic transport vehicle designed to transport trade goods across the earth wherever necessary while being able to outrun and take a few shots from the usual raider interception. It comes after-market equipped with tesla coils due to the xenomorph threats."
	icon = 'ntf_modular/icons/obj/vehicles/large_truck.dmi'
	damage_icon_path = 'ntf_modular/icons/obj/vehicles/large_truck.dmi'
	icon_state = "truck_enclosed"
	hitbox = /obj/hitbox/medium/truck
	interior = /datum/interior/armored/logi
	permitted_weapons = NONE
	permitted_mods = list(/obj/item/tank_module/ability/tesla)
	armored_flags = ARMORED_HAS_HEADLIGHTS|ARMORED_WRECKABLE|ARMORED_SELF_WALL_DAMAGE
	required_entry_skill = SKILL_LARGE_VEHICLE_DEFAULT
	minimap_icon_state = null
	turret_icon = null
	pixel_x = -16
	pixel_y = -40
	max_integrity = 700
	soft_armor = list(MELEE = 50, BULLET = 80 , LASER = 80, ENERGY = 70, BOMB = 30, BIO = 100, FIRE = 100, ACID = 50)
	hard_armor = list(MELEE = 0, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 5, BIO = 100, FIRE = 0, ACID = 0)
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.8, VEHICLE_SIDE_ARMOUR = 1, VEHICLE_BACK_ARMOUR = 1.2) //not too much diff
	ram_damage = 150
	move_delay = 0.1 SECONDS
	glide_size = 9
	easy_load_list = list(
		/obj/item/ammo_magazine/tank,
		/obj/structure/largecrate,
		/obj/structure/closet/crate,
	)
	armor_integrity_mod = 8 //10 initial ap to penetrate, large caliber rifles and shouldnt bounce off.

/obj/vehicle/sealed/armored/multitile/mrap/logi/enter_locations(atom/movable/entering_thing)
	return list(get_step(src, REVERSE_DIR(dir)))

/obj/vehicle/sealed/armored/multitile/mrap/logi/treads
	name = "\improper TransCO 'Roughauler' Treaded Military Truck"
	desc = "A treaded, armored logistic transport vehicle, designed to transport troops and supplies wherever necessary, relatively quickly and hopefully in one piece thanks to it's ballistic plating. It's threads make it possible to turn on spot, be immune to flat tires, resist side-shots and traverse rough terrain, probably.  It comes after-market equipped with tesla coils due to the xenomorph threats."
	icon = 'icons/obj/vehicles/large_truck.dmi'
	icon_state = "truck_enclosed_treads"
	hitbox = /obj/hitbox/medium
	max_integrity = 800
	soft_armor = list(MELEE = 50, BULLET = 80 , LASER = 80, ENERGY = 70, BOMB = 50, BIO = 100, FIRE = 100, ACID = 55)
	hard_armor = list(MELEE = 0, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.8, VEHICLE_SIDE_ARMOUR = 0.8, VEHICLE_BACK_ARMOUR = 1.2) //tracks are armored yay
	move_delay = 0.2 SECONDS
	glide_size = 7
	armor_integrity_mod = 5 //16 initial ap to penetrate, should tank large caliber rifles.

//logistic trucc 2x2
/obj/hitbox/medium/truck
	vehicle_width = 64

/obj/hitbox/medium/truck/owner_turned(datum/source, old_dir, new_dir)
	. = ..()
	if(!.)
		return
	var/list/old_locs = locs.Copy()
	var/angle_change = dir2angle(new_dir) - dir2angle(old_dir)
	//north needing to be considered 0 OR 360 is inconvenient, I'm sure there is a non ungabrain way to do this
	switch(angle_change)
		if(-270)
			angle_change = 90
		if(270)
			angle_change = -90
	for(var/mob/living/desant AS in tank_desants)
		if(desant.loc == root.loc)
			continue
		var/new_x
		var/new_y
		if(angle_change > 0) //clockwise turn
			new_x = root.x + (desant.y - root.y)
			new_y = root.y - (desant.x - root.x)
		else //anti-clockwise
			new_x = root.x - (desant.y - root.y)
			new_y = root.y + (desant.x - root.x)

		desant.forceMove(locate(new_x, new_y, z))

	switch(new_dir)
		if(NORTH)
			root.pixel_x = -16
			root.pixel_y = -40
			vehicle_width = 32
		if(SOUTH)
			root.pixel_x = -16
			root.pixel_y = -40
			vehicle_width = 32
		if(WEST)
			root.pixel_x = -32
			root.pixel_y = -20
			vehicle_width = 64
		if(EAST)
			root.pixel_x = -32
			root.pixel_y = -20
			vehicle_width = 64


	SEND_SIGNAL(src, COMSIG_MULTITILE_VEHICLE_ROTATED, loc, new_dir, null, old_locs)

/obj/hitbox/medium/truck/on_attempt_drive(atom/movable/movable_parent, mob/living/user, direction)
	var/obj/vehicle/sealed/armored/armor = root
	var/movement_dir
	var/facing_dir = armor.dir

	var/turf/centerturf = get_turf(root)
	var/list/enteringturfs = list()

	if(!ISDIAGONALDIR(direction))
		if(direction == NORTH)
			movement_dir = facing_dir
		else if(direction == SOUTH)
			movement_dir = REVERSE_DIR(facing_dir)
		else //no strafing
			return COMPONENT_DRIVER_BLOCK_MOVE
		centerturf = get_step(get_step(centerturf, movement_dir), movement_dir)
		enteringturfs += centerturf
		enteringturfs += get_step(centerturf, turn(facing_dir, -90))
	else //turn
		if(direction & WEST)
			movement_dir = turn(facing_dir, 90)
			centerturf = get_step(centerturf, movement_dir)
		else
			movement_dir = turn(facing_dir, -90)
			centerturf = get_step(get_step(centerturf, movement_dir), movement_dir)

		if(direction & NORTH)
			facing_dir = movement_dir
			enteringturfs += get_step(centerturf, armor.dir)
		else
			facing_dir = REVERSE_DIR(movement_dir)
			enteringturfs += get_step(centerturf, REVERSE_DIR(armor.dir))

		enteringturfs += centerturf

	var/canstep = TRUE
	for(var/turf/T AS in enteringturfs)	//No break because we want to crush all the turfs before we start trying to move
		if(!T.Enter(root, movement_dir))	//Check if we can cross the turf first/bump the turf
			canstep = FALSE

		for(var/atom/movable/AM AS in T.contents) // this is checked in turf/enter but it doesnt return false so lmao
			if(AM.pass_flags & PASS_TANK) //rather than add it to AM/CanAllowThrough for this one interaction, lets just check it manually
				continue
			if(AM.CanPass(root))	// Then check for obstacles to crush
				continue
			root.Bump(AM) //manually call bump on everything
			canstep = FALSE

	if(!canstep)
		return COMPONENT_DRIVER_BLOCK_MOVE

	if(!ISDIAGONALDIR(direction))
		armor.forceMove(get_step(armor.loc, movement_dir))
		return COMPONENT_DRIVER_BLOCK_MOVE
	//moving left, our mid point stays unchanged either way
	if(direction == NORTHEAST)
		armor.forceMove(get_step(armor.loc, turn(armor.dir, -45)))
	else if(direction == SOUTHEAST)
		armor.forceMove(get_step(armor.loc, turn(armor.dir, -135)))

	root.setDir(facing_dir)
	COOLDOWN_START(root, cooldown_vehicle_move, root.move_delay * 2)  //turns are essentially making two moves
	return COMPONENT_DRIVER_BLOCK_MOVE
