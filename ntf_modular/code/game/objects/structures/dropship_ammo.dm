/obj/structure/ship_ammo/cas/minirocket/satrapine
	name = "Satrapine mini rocket stack"
	desc = "A pack of laser guided mini rockets loaded with pain inducing Satrapine gas. Moving this will require some sort of lifter."
	icon_state = "minirocket_satrapine"
	icon = 'ntf_modular/icons/obj/structures/prop/mainship.dmi'
	point_cost = 250
	devastating_explosion_range = 0
	travelling_time = 4 SECONDS
	heavy_explosion_range = 0
	light_explosion_range = 2
	cas_effect = /obj/effect/overlay/blinking_laser/tfoot
	crosshair = 'ntf_modular/icons/UI_icons/cas_crosshairs/rocket_satrapine.dmi'

/obj/structure/ship_ammo/cas/minirocket/satrapine/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	var/datum/effect_system/smoke_spread/satrapine/S = new
	S.set_up(2, impact, 9)
	S.start()
	for(var/obj/machinery/deployable/mounted/sentry/ads_system/ads in range(GLOB.ads_intercept_range,impact))
		if(!COOLDOWN_FINISHED(ads, intercept_cooldown))
			continue
		if(ads.try_intercept(impact, src, 0.5, 5))
			return
	explosion(impact, devastating_explosion_range, heavy_explosion_range, light_explosion_range, throw_range = 0, explosion_cause=src)

/obj/structure/ship_ammo/cas/minirocket/KnockOut
	name = "KnockOut mini rocket stack"
	desc = "A pack of laser guided mini rockets loaded with sleep inducing KnockOut gas. Moving this will require some sort of lifter."
	icon_state = "minirocket_knockout"
	icon = 'ntf_modular/icons/obj/structures/prop/mainship.dmi'
	point_cost = 250
	devastating_explosion_range = 0
	travelling_time = 4 SECONDS
	heavy_explosion_range = 0
	light_explosion_range = 2
	cas_effect = /obj/effect/overlay/blinking_laser/tfoot
	crosshair = 'ntf_modular/icons/UI_icons/cas_crosshairs/rocket_KnockOut.dmi'

/obj/structure/ship_ammo/cas/minirocket/KnockOut/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	var/datum/effect_system/smoke_spread/sleepy/S = new
	S.set_up(2, impact, 9)
	S.start()
	for(var/obj/machinery/deployable/mounted/sentry/ads_system/ads in range(GLOB.ads_intercept_range,impact))
		if(!COOLDOWN_FINISHED(ads, intercept_cooldown))
			continue
		if(ads.try_intercept(impact, src, 0.5, 5))
			return
	explosion(impact, devastating_explosion_range, heavy_explosion_range, light_explosion_range, throw_range = 0, explosion_cause=src)
