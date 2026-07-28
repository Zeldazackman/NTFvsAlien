


/datum/interior/armored/logi
	template = /datum/map_template/interior/logi

/datum/map_template/interior/logi
	name = "transport truck interior template"
	filename = "logitruck"

/obj/vehicle/sealed/armored/multitile/mrap/logi
	name = "\improper TransCO 'Roughauler' Military Truck"
	desc = "A lightly armored logistic transport vehicle designed to transport troops and supplies wherever necessary, quickly and hopefully in one piece."
	icon = 'ntf_modular/icons/obj/vehicles/large_truck.dmi'
	icon_state = "truck_enclosed"
	hitbox = /obj/hitbox/thin
	interior = /datum/interior/armored/logi
	permitted_weapons = NONE
	permitted_mods = list(/obj/item/tank_module/ability/tesla)
	armored_flags = ARMORED_HAS_HEADLIGHTS|ARMORED_WRECKABLE|ARMORED_SELF_WALL_DAMAGE
	required_entry_skill = SKILL_LARGE_VEHICLE_DEFAULT
	minimap_icon_state = null
	turret_icon = null
	pixel_x = -32
	pixel_y = -32
	max_integrity = 700
	soft_armor = list(MELEE = 50, BULLET = 70 , LASER = 70, ENERGY = 60, BOMB = 60, BIO = 100, FIRE = 100, ACID = 50)
	hard_armor = list(MELEE = 0, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.8, VEHICLE_SIDE_ARMOUR = 1, VEHICLE_BACK_ARMOUR = 1.2) //not too much diff
	ram_damage = 150
	move_delay = 0.1 SECONDS
	glide_size = 9
	easy_load_list = list(
		/obj/item/ammo_magazine/tank,
		/obj/structure/largecrate,
		/obj/structure/closet/crate,
	)

/obj/vehicle/sealed/armored/multitile/mrap/logi/treads
	name = "\improper TransCO 'Roughauler-T' Treaded Military Truck"
	desc = "A lightly armored logistic transport vehicle with treads designed to transport troops and supplies wherever necessary, quickly and hopefully in one piece. It's threads make it possible to turn on spot, be immune to flat tires and traverse rough terrain, probably."
	icon = 'icons/obj/vehicles/large_truck.dmi'
	icon_state = "truck_enclosed_treads"
	max_integrity = 750
	soft_armor = list(MELEE = 50, BULLET = 80 , LASER = 80, ENERGY = 70, BOMB = 70, BIO = 100, FIRE = 100, ACID = 55)
	hard_armor = list(MELEE = 0, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.8, VEHICLE_SIDE_ARMOUR = 0.8, VEHICLE_BACK_ARMOUR = 1.2) //tracks are armored yay
	move_delay = 0.15 SECONDS
	glide_size = 8.5

//logistic trucc 1x3
/obj/hitbox/thin
	bound_x = 0
	bound_y = -32
	vehicle_length = 96
	vehicle_width = 32

/obj/hitbox/thin/owner_turned(datum/source, old_dir, new_dir)
	. = ..()
	if(!.)
		return
	var/list/old_locs = locs.Copy()
	switch(new_dir)
		if(NORTH)
			bound_height = vehicle_length
			bound_width = vehicle_width
			bound_x = 0
			bound_y = -32
		if(SOUTH)
			bound_height = vehicle_length
			bound_width = vehicle_width
			bound_x = -0
			bound_y = -32
		if(WEST)
			bound_height = vehicle_width
			bound_width = vehicle_length
			bound_x = 0
			bound_y = 0
		if(EAST)
			bound_height = vehicle_width
			bound_width = vehicle_length
			bound_x = 0
			bound_y = 0

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

	SEND_SIGNAL(src, COMSIG_MULTITILE_VEHICLE_ROTATED, loc, new_dir, null, old_locs)

/obj/hitbox/thin/on_attempt_drive(atom/movable/movable_parent, mob/living/user, direction)
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


//threaded hitbox behavior
/obj/hitbox/thin_threads
	bound_x = 0
	bound_y = -32
	vehicle_length = 96
	vehicle_width = 32
