
/atom/movable/screen/map_view/preference_preview
	/// All the plane masters that need to be applied.
	var/atom/movable/screen/background/screen_bg

/atom/movable/screen/map_view/preference_preview/Destroy()
	QDEL_NULL(screen_bg)
	return ..()

/atom/movable/screen/map_view/preference_preview/generate_view(map_key)
	. = ..()
	screen_bg = new
	screen_bg.del_on_map_removal = FALSE
	screen_bg.assigned_map = assigned_map
	screen_bg.icon_state = "clear"
	screen_bg.fill_rect(1, 1, 4, 1)

/atom/movable/screen/map_view/preference_preview/display_to_client(client/show_to)
	show_to.register_map_obj(screen_bg)
	return ..()

/datum/preferences/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)

		ui = new(user, src, "PlayerPreferences", "Preferences")
		ui.set_autoupdate(FALSE)
		ui.open()
		screen_main.display_to(user, ui.window)

/datum/preferences/ui_close(mob/user)
	. = ..()
	user.client?.clear_map(map_name)
	user.client?.clear_character_previews()

/datum/preferences/ui_state(mob/user)
	return GLOB.always_state

/datum/preferences/ui_data(mob/user)
	var/list/data = list()
	data["tabIndex"] = tab_index
	if(!path)
		. = data
		CRASH("no path")
	var/savefile/S = new (path)
	if(!S)
		. = data
		CRASH("no savefile for path [path]")
	var/slotname
	S.cd = "/character[default_slot]"
	S["real_name"] >> slotname
	if(!slotname)
		slotname = "\[empty\]"
	data["slot"] = "[default_slot] - [slotname]"

	data["unique_action_use_active_hand"] = unique_action_use_active_hand

	switch(tab_index)
		if(CHARACTER_CUSTOMIZATION)
			data["r_hair"] = r_hair
			data["g_hair"] = g_hair
			data["b_hair"] = b_hair
			data["r_grad"] = r_grad
			data["g_grad"] = g_grad
			data["b_grad"] = b_grad
			data["r_facial"] = r_facial
			data["g_facial"] = g_facial
			data["b_facial"] = b_facial
			data["r_eyes"] = r_eyes
			data["g_eyes"] = g_eyes
			data["b_eyes"] = b_eyes
			data["real_name"] = real_name
			data["xeno_name"] = xeno_name
			data["synthetic_name"] = synthetic_name
			data["synthetic_type"] = synthetic_type
			data["robot_type"] = robot_type
			data["moth_wings"] = moth_wings
			data["random_name"] = random_name
			data["ai_name"] = ai_name
			data["age"] = age
			data["gender"] = gender
			data["physique"] = physique
			data["ethnicity"] = ethnicity
			data["species"] = species || "Human"
			data["good_eyesight"] = good_eyesight
			data["citizenship"] = citizenship
			data["tts_voice"] = tts_voice
			data["tts_pitch"] = "[tts_pitch]"
			data["religion"] = religion
			data["h_style"] = h_style
			data["grad_style"] = grad_style
			data["f_style"] = f_style
		if(BACKGROUND_INFORMATION)
			data["flavor_text"] = html_decode(flavor_text)
			data["xeno_desc"] = html_decode(xeno_desc)
			data["profile_pic"] = html_decode(profile_pic)
			data["nsfwprofile_pic"] = html_decode(nsfwprofile_pic)
			data["xenoprofile_pic"] = html_decode(xenoprofile_pic)
			data["med_record"] = html_decode(med_record)
			data["gen_record"] = html_decode(gen_record)
			data["sec_record"] = html_decode(sec_record)
			data["exploit_record"] = html_decode(exploit_record)
		if(FLAVOR_CUSTOMIZATION)
			data["xeno_edible_jelly_name"] = xeno_edible_jelly_name
			data["r_jelly"] = r_jelly
			data["g_jelly"] = g_jelly
			data["b_jelly"] = b_jelly
			data["xeno_edible_jelly_desc"] = xeno_edible_jelly_desc
			data["xeno_edible_jelly_flavors"] = xeno_edible_jelly_flavors
		if(GEAR_CUSTOMIZATION)
			data["gearsets"] = list()
			for(var/g in GLOB.gear_datums)
				var/datum/gear/gearset = GLOB.gear_datums[g]
				data["gearsets"][gearset.display_name] = list(
					"name" = gearset.display_name,
					"cost" = gearset.cost,
					"slot" = gearset.slot,
				)
			data["gear"] = gear || list()
			/*NTF removal
			data["undershirt"] = undershirt
			data["underwear"] = underwear
			*/
			data["backpack"] = backpack
			data["physique_used"] = get_physique()
		if(JOB_PREFERENCES)
			data["job_preferences"] = job_preferences
			data["preferred_squad"] = preferred_squad
			data["preferred_squad_som"] = preferred_squad_som
			data["alternate_option"] = alternate_option
			data["special_occupation"] = be_special
		if(GAME_SETTINGS)
			data["is_admin"] = user.client?.holder ? TRUE : FALSE
			data["ui_style_color"] = ui_style_color
			data["ui_style"] = ui_style
			data["ui_style_alpha"] = ui_style_alpha
			data["windowflashing"] = windowflashing
			data["auto_fit_viewport"] = auto_fit_viewport
			data["mute_xeno_health_alert_messages"] = mute_xeno_health_alert_messages
			data["sound_tts"] = sound_tts
			data["volume_tts"] = volume_tts
			data["radio_tts_flags"] = radio_tts_flags
			data["accessible_tgui_themes"] = accessible_tgui_themes
			data["allow_being_shown_health_scan"] = allow_being_shown_health_scan
			data["tgui_fancy"] = tgui_fancy
			data["tgui_lock"] = tgui_lock
			data["ui_scale"] = ui_scale
			data["tgui_input"] = tgui_input
			data["tgui_input_big_buttons"] = tgui_input_big_buttons
			data["tgui_input_buttons_swap"] = tgui_input_buttons_swap
			data["clientfps"] = clientfps
			data["chat_on_map"] = chat_on_map
			data["max_chat_length"] = max_chat_length
			data["see_chat_non_mob"] = see_chat_non_mob
			data["see_rc_emotes"] = see_rc_emotes
			data["toggle_bump_attacking"] = toggle_bump_attacking
			data["mute_others_combat_messages"] = mute_others_combat_messages
			data["mute_self_combat_messages"] = mute_self_combat_messages
			data["show_xeno_rank"] = show_xeno_rank
			data["show_typing"] = show_typing
			data["toggle_adminhelp_sound"] = !!(toggles_sound & SOUND_ADMINHELP)
			data["toggle_admin_music"] = !!(toggles_sound & SOUND_MIDI)
			data["toggle_ambience_sound"] = !!(toggles_sound & SOUND_AMBIENCE)
			data["toggle_lobby_music"] = !!(toggles_sound & SOUND_LOBBY)
			data["toggle_instruments_sound"] = !(toggles_sound & SOUND_INSTRUMENTS_OFF)
			data["toggle_weather_sound"] = !!(toggles_sound & SOUND_WEATHER)
			data["toggle_round_end_sounds"] = !(toggles_sound & SOUND_NOENDOFROUND)
			data["tooltips"] = tooltips
			data["widescreenpref"] = widescreenpref
			data["radialmedicalpref"] = !!(toggles_gameplay & RADIAL_MEDICAL)
			data["radialstackspref"] = !!(toggles_gameplay & RADIAL_STACKS)
			data["radiallasersgunpref"] = !!(toggles_gameplay & RADIAL_LASERGUNS)
			data["autointeractdeployablespref"] = !!(toggles_gameplay & AUTO_INTERACT_DEPLOYABLES)
			data["directional_attacks"] = !!(toggles_gameplay & DIRECTIONAL_ATTACKS)
			data["toggle_clickdrag"] = !(toggles_gameplay & TOGGLE_CLICKDRAG)
			data["toggle_xeno_move_intent_keybind"] = !!(toggles_gameplay & TOGGLE_XENO_MOVE_INTENT_KEYBIND)
			data["scaling_method"] = scaling_method
			data["pixel_size"] = pixel_size
			data["parallax"] = parallax
			data["fullscreen_mode"] = fullscreen_mode
			data["show_status_bar"] = show_status_bar
			data["ambient_occlusion"] = ambient_occlusion
			data["multiz_parallax"] = multiz_parallax
			data["multiz_performance"] = multiz_performance
			data["fast_mc_refresh"] = fast_mc_refresh
			data["split_admin_tabs"] = split_admin_tabs
			data["hear_ooc_anywhere_as_staff"] = hear_ooc_anywhere_as_staff
		if(KEYBIND_SETTINGS)
			data["is_admin"] = user.client?.holder ? TRUE : FALSE
			data["key_bindings"] = list()
			for(var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					data["key_bindings"][kb_name] += list(key)
			data["custom_emotes"] = list()
			for(var/id in 1 to CUSTOM_EMOTE_SLOTS)
				var/datum/custom_emote/emote = custom_emotes[id]
				data["custom_emotes"]["Custom emote :[id]"] = list(
					sentence = emote.message,
					emote_type = (emote.spoken_emote ? "say" : "me"),
					)
		if(DRAW_ORDER)
			data["draw_order"] = list()
			for(var/slot in slot_draw_order_pref)
				data["draw_order"] += slot_flag_to_fluff(slot)
			data["quick_equip"] = list()
			for(var/quick_equip_slots in quick_equip)
				data["quick_equip"] += slot_flag_to_fluff(quick_equip_slots)
	return data

/datum/preferences/ui_static_data(mob/user)
	. = list()
	switch(tab_index)
		if(CHARACTER_CUSTOMIZATION)
			update_preview_icon()
			.["mapRef"] = "player_pref_map"
		if(GEAR_CUSTOMIZATION)
			.["clothing"] = list(
				"backpack" = GLOB.backpacklist,
				)
			.["gearsets"] = list()
			for(var/g in GLOB.gear_datums)
				var/datum/gear/gearset = GLOB.gear_datums[g]
				.["gearsets"][gearset.display_name] = list(
					"name" = gearset.display_name,
					"cost" = gearset.cost,
					"slot" = gearset.slot,
				)
		if(JOB_PREFERENCES)
			.["squads"] = SELECTABLE_SQUADS
			.["squads_som"] = SELECTABLE_SQUADS_SOM
			.["jobs"] = list()
			for(var/datum/job/job AS in SSjob.joinable_occupations)
				var/rank = job.title
				.["jobs"][rank] = list(
					"color" = job.selection_color,
					"description" = job.html_description,
					"banned" = is_banned_from(user.ckey, rank),
					"playtime_req" = job.required_playtime_remaining(user.client),
					"account_age_req" = !job.player_old_enough(user.client),
					"flags" = list(
						"bold" = (job.job_flags & JOB_FLAG_BOLD_NAME_ON_SELECTION) ? TRUE : FALSE
					)
				)
			.["overflow_job"] = SSjob?.overflow_role?.title
			.["special_occupations"] = list(
				"Latejoin Xenomorph" = BE_ALIEN,
				"Xenomorph when unrevivable" = BE_ALIEN_UNREVIVABLE,
				"End of Round Deathmatch" = BE_DEATHMATCH,
				"Eligible for Hive Target" = BE_HIVE_TARGET,
				"Prefer Squad over Role" = BE_SQUAD_STRICT,
				"Use random name when taking SSD mobs" = BE_SSD_RANDOM_NAME
			)
		if(KEYBIND_SETTINGS)
			.["all_keybindings"] = list()
			for(var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				.["all_keybindings"][kb.category] += list(list(
					name = kb.name,
					display_name = kb.full_name,
					desc = kb.description,
					category = kb.category,
				))

/datum/preferences/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	var/client/current_client = CLIENT_FROM_VAR(usr)
	var/mob/user = current_client.mob

	switch(action)
		if("changeslot")
			var/list/slots = list()
			if(!path)
				CRASH("no path")
			var/savefile/S = new (path)
			if(!S)
				CRASH("no savefile for path [path]")
			var/slotname
			for(var/i in 1 to MAX_SAVE_SLOTS)
				S.cd = "/character[i]"
				S["real_name"] >> slotname
				if(!slotname)
					slotname = "\[empty\]"
				slots += "[i] - [slotname]"
			var/choice = tgui_input_list(ui.user, "What slot do you want to load?", "Character slot choice", slots)
			if(!choice)
				return
			if(!load_character(text2num(splittext(choice," - ")[1])))
				random_character()
				real_name = random_unique_name(gender)
				save_character()
			update_preview_icon()

		if("tab_change")
			tab_index = params["tabIndex"]
			update_static_data(ui.user, ui)

		if("random")
			randomize_appearance_for()
			save_character()
			update_preview_icon()

		if("name_real")
			var/newValue = params["newValue"]
			newValue = reject_bad_name(newValue, TRUE)
			if(!newValue)
				tgui_alert(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>", "Invalid name", list("Ok"))
				return
			real_name = newValue

		if("randomize_name")
			var/datum/species/S = GLOB.all_species[species]
			real_name = S.random_name(gender)

		if("toggle_always_random")
			random_name = !random_name

		if("randomize_appearance")
			randomize_appearance_for()
			update_preview_icon()

		if("synthetic_name")
			var/newValue = params["newValue"]
			newValue = reject_bad_name(newValue, TRUE)
			if(!newValue)
				tgui_alert(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>", "Invalid name", list("Ok"))
				return
			synthetic_name = newValue

		if("synthetic_type")
			var/choice = tgui_input_list(ui.user, "What kind of synthetic do you want to play with?", "Synthetic type choice", SYNTH_TYPES)
			if(!choice)
				return
			synthetic_type = choice
			update_preview_icon()

		if("robot_type")
			var/choice = tgui_input_list(ui.user, "What model of robot do you want to play with?", "Robot model choice", ROBOT_TYPES)
			if(!choice)
				return
			robot_type = choice
			update_preview_icon()

		if("moth_wings")
			var/choice = tgui_input_list(ui.user, "What kind of moth wings do you want to play with? Only useable as a moth.", "Moth with type choice", GLOB.moth_wings_list)
			if(!choice)
				return
			moth_wings = choice
			update_preview_icon()

		if("xeno_name")
			var/newValue = params["newValue"]
			if(newValue == "")
				xeno_name = "Undefined"
			else
				newValue = reject_bad_name(newValue)
				if(!newValue)
					tgui_alert(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>", "Invalid name", list("Ok"))
					return
				xeno_name = newValue

		if("ai_name")
			var/newValue = params["newValue"]
			if(newValue == "")
				ai_name = "ARES v3.2"
			else
				newValue = reject_bad_name(newValue, TRUE)
				if(!newValue)
					tgui_alert(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>", "Invalid name", list("Ok"))
					return
				ai_name = newValue

		if("age")
			var/new_age = text2num(params["newValue"])
			if(!isnum(new_age))
				return
			new_age = round(new_age)
			age = clamp(new_age, AGE_MIN, AGE_MAX)

		if("toggle_gender")
			gender = params["newgender"]
			if(physique == USE_GENDER)
				update_preview_icon()

		if("toggle_physique")
			physique = params["newphysique"]
			/* NTF Removal
			var/physique_to_check = get_physique()
			if(physique_to_check == FEMALE)
				f_style = "Shaved"
			else
				underwear = 1
			*/
			update_preview_icon()

		if("ethnicity")
			var/choice = tgui_input_list(ui.user, "What ethnicity do you want to play with?", "Ethnicity choice", GLOB.ethnicities_list)
			if(!choice)
				return
			ethnicity = choice
			update_preview_icon()

		if("species")
			var/choice = tgui_input_list(ui.user, "What species do you want to play with?", "Species choice", get_playable_species())
			if(!choice || species == choice)
				return
			species = choice
			var/datum/species/S = GLOB.all_species[species]
			real_name = S.random_name(gender)
			update_preview_icon()

		if("toggle_eyesight")
			good_eyesight = !good_eyesight

		if("be_special")
			var/flag = text2num(params["flag"])
			TOGGLE_BITFIELD(be_special, flag)

		if("jobselect")
			UpdateJobPreference(user, params["job"], text2num(params["level"]))
			update_preview_icon()

		if("jobalternative")
			var/newValue = text2num(params["newValue"])
			alternate_option = clamp(newValue, 0, 2)

		if("jobreset")
			job_preferences = list()
			preferred_squad = "None"
			preferred_squad_som = "None"
			alternate_option = 2 // return to lobby
			update_preview_icon()

		/** NTF removal - we are using our own fancy underwear system

		if("underwear")
			var/list/underwear_options
			var/physique_to_check = get_physique()
			if(physique_to_check == MALE)
				underwear_options = GLOB.underwear_m
			else
				underwear_options = GLOB.underwear_f

			var/new_underwear = underwear_options.Find(params["newValue"])
			if(!new_underwear)
				return
			underwear = new_underwear
			update_preview_icon()

		if("undershirt")
			var/list/undershirt_options
			var/physique_to_check = physique == USE_GENDER ? gender : physique
			if(physique_to_check == MALE)
				undershirt_options = GLOB.undershirt_m
			else
				undershirt_options = GLOB.undershirt_f

			var/new_undershirt = undershirt_options.Find(params["newValue"])
			if(!new_undershirt)
				return
			undershirt = new_undershirt
			update_preview_icon()
		*/

		if("backpack")
			var/new_backpack = GLOB.backpacklist.Find(params["newValue"])
			if(!new_backpack)
				return
			backpack = new_backpack
			update_preview_icon()

		if("loadoutadd")
			var/choice = params["gear"]
			if(!(choice in GLOB.gear_datums))
				return

			var/total_cost = 0
			var/datum/gear/C = GLOB.gear_datums[choice]

			if(!C)
				return

			if(length(gear))
				for(var/gear_name in gear)
					if(GLOB.gear_datums[gear_name])
						var/datum/gear/G = GLOB.gear_datums[gear_name]
						total_cost += G.cost

			total_cost += C.cost
			if(total_cost <= MAX_GEAR_COST)
				if(!islist(gear))
					gear = list()
				gear += choice
				to_chat(user, span_notice("Added '[choice]' for [C.cost] points ([MAX_GEAR_COST - total_cost] points remaining)."))
			else
				to_chat(user, span_warning("Adding '[choice]' will exceed the maximum loadout cost of [MAX_GEAR_COST] points."))

		if("loadoutremove")
			gear.Remove(params["gear"])
			if(!islist(gear))
				gear = list()

		if("loadoutclear")
			gear.Cut()
			if(!islist(gear))
				gear = list()

		if("ui")
			var/choice = tgui_input_list(ui.user, "What UI style do you want?", "UI style choice", UI_STYLES)
			if(!choice)
				return
			ui_style = choice

		if("uicolor")
			var/ui_style_color_new = input(user, "Choose your UI color, dark colors are not recommended!", "UI Color") as null|color
			if(!ui_style_color_new)
				return
			ui_style_color = ui_style_color_new

		if("uialpha")
			var/ui_style_alpha_new = text2num(params["newValue"])
			if(!ui_style_alpha_new)
				return
			ui_style_alpha_new = round(ui_style_alpha_new)
			ui_style_alpha = clamp(ui_style_alpha_new, 55, 230)

		if("hairstyle")
			var/list/valid_hairstyles = list()
			for(var/hairstyle in GLOB.hair_styles_list)
				var/datum/sprite_accessory/S = GLOB.hair_styles_list[hairstyle]
				if(!(species in S.species_allowed))
					continue

				valid_hairstyles[hairstyle] = GLOB.hair_styles_list[hairstyle]
			var/choice = tgui_input_list(ui.user, "What hair style do you want?", "Hair style choice", valid_hairstyles)
			if(!choice)
				return
			h_style = choice
			update_preview_icon()

		if("haircolor")
			var/new_color = input(user, "Choose your character's hair colour:", "Hair Color") as null|color
			if(!new_color)
				return
			r_hair = hex2num(copytext(new_color, 2, 4))
			g_hair = hex2num(copytext(new_color, 4, 6))
			b_hair = hex2num(copytext(new_color, 6, 8))
			update_preview_icon()

		if("grad_color")
			var/new_grad = input(user, "Choose your character's secondary hair color:", "Gradient Color") as null|color
			if(!new_grad)
				return
			r_grad = hex2num(copytext(new_grad, 2, 4))
			g_grad = hex2num(copytext(new_grad, 4, 6))
			b_grad = hex2num(copytext(new_grad, 6, 8))
			update_preview_icon()

		if("grad_style")
			var/list/valid_grads = list()
			for(var/grad in GLOB.hair_gradients_list)
				var/datum/sprite_accessory/S = GLOB.hair_gradients_list[grad]
				if(!(species in S.species_allowed))
					continue

				valid_grads[grad] = GLOB.hair_gradients_list[grad]

			var/choice = tgui_input_list(ui.user, "What hair grad style do you want?", "Hair grad style choice", valid_grads)
			if(choice)
				grad_style = choice
			update_preview_icon()

		if("facial_style")
			var/list/valid_facialhairstyles = list()
			for(var/facialhairstyle in GLOB.facial_hair_styles_list)
				var/datum/sprite_accessory/S = GLOB.facial_hair_styles_list[facialhairstyle]
				if(physique == FEMALE && S.gender == MALE)
					continue
				if(!(species in S.species_allowed))
					continue

				valid_facialhairstyles[facialhairstyle] = GLOB.facial_hair_styles_list[facialhairstyle]

			var/choice = tgui_input_list(ui.user, "What facial hair style do you want?", "Facial hair style choice", valid_facialhairstyles)
			if(!choice)
				return
			f_style = choice
			update_preview_icon()

		if("facialcolor")
			var/facial_color = input(user, "Choose your character's facial-hair colour:", "Facial Hair Color") as null|color
			if(!facial_color)
				return
			r_facial = hex2num(copytext(facial_color, 2, 4))
			g_facial = hex2num(copytext(facial_color, 4, 6))
			b_facial = hex2num(copytext(facial_color, 6, 8))
			update_preview_icon()

		if("eyecolor")
			var/eyecolor = input(user, "Choose your character's eye colour:", "Character Preference") as null|color
			if(!eyecolor)
				return
			r_eyes = hex2num(copytext(eyecolor, 2, 4))
			g_eyes = hex2num(copytext(eyecolor, 4, 6))
			b_eyes = hex2num(copytext(eyecolor, 6, 8))
			update_preview_icon()

		if("citizenship")
			var/choice = tgui_input_list(ui.user, "Where do you hail from?", "Place of Origin", CITIZENSHIP_CHOICES)
			if(!choice)
				return
			citizenship = choice

		if("religion")
			var/choice = tgui_input_list(ui.user, "What religion do you belive in?", "Belief", RELIGION_CHOICES)
			if(!choice)
				return
			religion = choice

		if("tts_voice")
			var/list/voices
			if(SStts.tts_enabled)
				voices = SStts.available_speakers
			else if(fexists("data/cached_tts_voices.json"))
				var/list/text_data = rustg_file_read("data/cached_tts_voices.json")
				voices = json_decode(text_data)
			if(!length(voices))
				return
			var/choice = tgui_input_list(ui.user, "What do you sound like?", "TTS", voices)
			if(!choice)
				return
			tts_voice = choice
			if(TIMER_COOLDOWN_RUNNING(user, COOLDOWN_TRY_TTS))
				return
			TIMER_COOLDOWN_START(ui.user, COOLDOWN_TRY_TTS, 0.5 SECONDS)
			INVOKE_ASYNC(SStts, TYPE_PROC_REF(/datum/controller/subsystem/tts, queue_tts_message), ui.user.client, "Hello, this is my voice.", speaker = choice, local = TRUE, special_filters = isrobot(GLOB.all_species[species]) ? TTS_FILTER_SILICON : "", pitch = tts_pitch)

		if("tts_pitch")
			tts_pitch = clamp(text2num(params["newValue"]), -12, 12)
			if(TIMER_COOLDOWN_RUNNING(user, COOLDOWN_TRY_TTS))
				return
			TIMER_COOLDOWN_START(ui.user, COOLDOWN_TRY_TTS, 0.5 SECONDS)
			INVOKE_ASYNC(SStts, TYPE_PROC_REF(/datum/controller/subsystem/tts, queue_tts_message), ui.user.client, "Hello, this is my voice.", speaker = tts_voice, local = TRUE, special_filters = isrobot(GLOB.all_species[species]) ? TTS_FILTER_SILICON : "", pitch = tts_pitch)

		if("squad")
			var/new_squad = params["newValue"]
			if(!(new_squad in SELECTABLE_SQUADS))
				return
			preferred_squad = new_squad

		if("squad_som")
			var/new_squad_som = params["newValue"]
			if(!(new_squad_som in SELECTABLE_SQUADS_SOM))
				return
			preferred_squad_som = new_squad_som

		if("med_record")
			var/new_record = trim(html_encode(params["medicalDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			med_record = new_record

		if("sec_record")
			var/new_record = trim(html_encode(params["securityDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			sec_record = new_record

		if("gen_record")
			var/new_record = trim(html_encode(params["employmentDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			gen_record = new_record

		if("exploit_record")
			var/new_record = trim(html_encode(params["exploitsDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			exploit_record = new_record

		if("flavor_text")
			var/new_record = trim(html_encode(params["characterDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			flavor_text = new_record

		if("xeno_desc")
			var/new_record = trim(html_encode(params["xenoDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			xeno_desc = new_record

		if("profile_pic")
			var/new_record = trim(html_encode(params["profilePic"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			if(new_record == "!clear")
				new_record = ""
			profile_pic = new_record

		if("nsfwprofile_pic")
			var/new_record = trim(html_encode(params["nsfwprofilePic"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			if(new_record == "!clear")
				new_record = ""
			nsfwprofile_pic = new_record

		if("xenoprofile_pic")
			var/new_record = trim(html_encode(params["xenoprofilePic"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			if(new_record == "!clear")
				new_record = ""
			xenoprofile_pic = new_record

		if("xenogender")
			var/new_xgender = text2num(params["newValue"])
			if(!isnum(new_xgender))
				return
			new_xgender = round(new_xgender)
			xenogender = new_xgender
		if("xeno_edible_jelly_name")
			var/newValue = params["newValue"]
			newValue = reject_bad_name(newValue, TRUE)
			if(!newValue)
				tgui_alert(user, "<font color='red'>Invalid name. The name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>", "Invalid name", list("Ok"))
				return
			xeno_edible_jelly_name = newValue

		if("xeno_edible_jelly_colors")
			var/jelly_color = input(user, "Choose the color of the jelly:", "Jelly Color") as null|color
			if(!jelly_color)
				return
			r_jelly = hex2num(copytext(jelly_color, 2, 4))
			g_jelly = hex2num(copytext(jelly_color, 4, 6))
			b_jelly = hex2num(copytext(jelly_color, 6, 8))

		if("xeno_edible_jelly_desc")
			var/new_record = trim(html_encode(params["xenoJellyDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			xeno_edible_jelly_desc = new_record

		if("xeno_edible_jelly_flavors")
			var/new_record = trim(html_encode(params["xenoJellyFlav"]), 256)
			if(!new_record)
				return
			xeno_edible_jelly_flavors = new_record

		if("xeno_edible_jelly_preview")
			usr.edible_jelly_preview("chat")

		if("windowflashing")
			windowflashing = !windowflashing

		if("auto_fit_viewport")
			auto_fit_viewport = !auto_fit_viewport
			parent?.attempt_auto_fit_viewport()

		if("mute_xeno_health_alert_messages")
			mute_xeno_health_alert_messages = !mute_xeno_health_alert_messages

		if("sound_tts")
			var/choice = tgui_input_list(ui.user, "What kind of TTS do you want?", "TTS choice", GLOB.all_tts_options)
			if(!choice)
				return
			sound_tts = choice

		if("volume_tts")
			var/new_vol = text2num(params["newValue"])
			if(!isnum(new_vol))
				return
			new_vol = round(new_vol)
			volume_tts = clamp(new_vol, 0, 100)

		if("toggle_radio_tts_setting")
			switch(params["newsetting"])
				if("sl")
					TOGGLE_BITFIELD(radio_tts_flags, RADIO_TTS_SL)
					if(!CHECK_BITFIELD(radio_tts_flags, RADIO_TTS_SL)) //When SL radio is being disabled, disable squad radio too
						DISABLE_BITFIELD(radio_tts_flags, RADIO_TTS_SQUAD)

				if("squad")
					TOGGLE_BITFIELD(radio_tts_flags, RADIO_TTS_SQUAD)
					if(CHECK_BITFIELD(radio_tts_flags, RADIO_TTS_SQUAD))
						ENABLE_BITFIELD(radio_tts_flags, RADIO_TTS_SL) //Enable SL TTS if not already enabled

				if("command")
					TOGGLE_BITFIELD(radio_tts_flags, RADIO_TTS_COMMAND)

				if("hivemind")
					TOGGLE_BITFIELD(radio_tts_flags, RADIO_TTS_HIVEMIND)

				if("all")
					TOGGLE_BITFIELD(radio_tts_flags, RADIO_TTS_ALL)
					if(CHECK_BITFIELD(radio_tts_flags, RADIO_TTS_ALL)) //Enable all other channels when 'ALL' is enabled
						for(var/flag in GLOB.all_radio_tts_options)
							ENABLE_BITFIELD(radio_tts_flags, flag)

			if(!CHECK_MULTIPLE_BITFIELDS(radio_tts_flags, RADIO_TTS_SL|RADIO_TTS_SQUAD|RADIO_TTS_COMMAND|RADIO_TTS_HIVEMIND))
				DISABLE_BITFIELD(radio_tts_flags, RADIO_TTS_ALL)

		if("accessible_tgui_themes")
			accessible_tgui_themes = !accessible_tgui_themes

		if("allow_being_shown_health_scan")
			allow_being_shown_health_scan = !allow_being_shown_health_scan

		if("tgui_fancy")
			tgui_fancy = !tgui_fancy

		if("tgui_lock")
			tgui_lock = !tgui_lock

		if("ui_scale")
			ui_scale = !ui_scale

			INVOKE_ASYNC(usr.client, TYPE_VERB_REF(/client, refresh_tgui))
			usr.client.tgui_say?.load()

		if("tgui_input")
			tgui_input = !tgui_input

		if("tgui_input_big_buttons")
			tgui_input_big_buttons = !tgui_input_big_buttons

		if("tgui_input_buttons_swap")
			tgui_input_buttons_swap = !tgui_input_buttons_swap

		if("clientfps")
			var/desiredfps = text2num(params["newValue"])
			if(!isnum(desiredfps))
				return
			desiredfps = clamp(desiredfps, 0, 240)
			clientfps = desiredfps
			parent.fps = desiredfps

		if("chat_on_map")
			chat_on_map = !chat_on_map

		if ("max_chat_length")
			var/desiredlength = text2num(params["newValue"])
			if(!isnull(desiredlength))
				max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)

		if("see_chat_non_mob")
			see_chat_non_mob = !see_chat_non_mob

		if("see_rc_emotes")
			see_rc_emotes = !see_rc_emotes

		if("toggle_bump_attacking")
			toggle_bump_attacking = !toggle_bump_attacking

		if("mute_self_combat_messages")
			mute_self_combat_messages = !mute_self_combat_messages

		if("mute_others_combat_messages")
			mute_others_combat_messages = !mute_others_combat_messages

		if("show_xeno_rank")
			show_xeno_rank = !show_xeno_rank

		if("change_quick_equip")
			var/editing_slot = params["selection"]
			var/slot = tgui_input_list(usr, "Which slot would you like to draw/equip from?", "Preferred Slot", SLOT_FLUFF_DRAW)
			if(!slot)
				return
			quick_equip[editing_slot] = slot_fluff_to_flag(slot)
			to_chat(src, span_notice("You will now equip/draw from the [slot] slot first."))

		if("equip_slot_equip_position")
			var/returned_item_list_position = slot_draw_order_pref.Find(slot_fluff_to_flag(params["changing_item"]))
			if(isnull(returned_item_list_position))
				return
			var/direction = params["direction"]
			if(!direction)
				return
			var/swapping_with = returned_item_list_position
			switch(direction)
				if("down")
					if(returned_item_list_position == length(SLOT_DRAW_ORDER))
						return
					swapping_with += 1
					slot_draw_order_pref.Swap(returned_item_list_position, swapping_with)
				if("up")
					if(returned_item_list_position == 1)
						return
					swapping_with -= 1
					slot_draw_order_pref.Swap(swapping_with, returned_item_list_position)

		if("show_typing")
			show_typing = !show_typing
			// Need to remove any currently shown
			if(!show_typing && istype(user))
				user.remove_all_indicators()

		if("tooltips")
			tooltips = !tooltips
			if(!tooltips)
				closeToolTip(usr)
			else if(!current_client.tooltips && tooltips)
				current_client.tooltips = new /datum/tooltip(current_client)

		if("toggle_adminhelp_sound")
			toggles_sound ^= SOUND_ADMINHELP

		if("toggle_admin_music")
			toggles_sound ^= SOUND_MIDI
			if(!(toggles_sound & SOUND_MIDI))
				user.stop_sound_channel(CHANNEL_MIDI)

		if("toggle_ambience_sound")
			toggles_sound ^= SOUND_AMBIENCE
			current_client.update_ambience_pref()
			if(!(toggles_sound & SOUND_AMBIENCE))
				user.stop_sound_channel(CHANNEL_AMBIENCE)

		if("toggle_lobby_music")
			toggles_sound ^= SOUND_LOBBY
			if(isnewplayer(user)) // can't do early return here, because buttons won't update properly outside of lobby
				if(toggles_sound & SOUND_LOBBY)
					current_client.play_title_music()
				else
					user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

		if("toggle_instruments_sound")
			toggles_sound ^= SOUND_INSTRUMENTS_OFF

		if("toggle_weather_sound")
			toggles_sound ^= SOUND_WEATHER

		if("toggle_round_end_sounds")
			toggles_sound ^= SOUND_NOENDOFROUND

		if("fullscreen_mode")
			fullscreen_mode = !fullscreen_mode
			user.client?.set_fullscreen(fullscreen_mode)

		if("show_status_bar")
			show_status_bar = !show_status_bar
			user.client?.toggle_status_bar(show_status_bar)

		if("ambient_occlusion")
			ambient_occlusion = !ambient_occlusion
			for(var/atom/movable/screen/plane_master/plane_master as anything in parent.mob?.hud_used?.get_true_plane_masters(GAME_PLANE))
				plane_master.show_to(parent.mob)

		if("multiz_parallax")
			multiz_parallax = !multiz_parallax
			var/datum/hud/my_hud = parent.mob?.hud_used
			if(!my_hud)
				return

			for(var/group_key as anything in my_hud.master_groups)
				var/datum/plane_master_group/group = my_hud.master_groups[group_key]
				group.build_planes_offset(my_hud, my_hud.current_plane_offset)

		if("multiz_performance")
			multiz_performance = WRAP(multiz_performance + 1, MULTIZ_PERFORMANCE_DISABLE, MAX_EXPECTED_Z_DEPTH)
			var/datum/hud/my_hud = parent.mob?.hud_used
			if(!my_hud)
				return

			for(var/group_key as anything in my_hud.master_groups)
				var/datum/plane_master_group/group = my_hud.master_groups[group_key]
				group.build_planes_offset(my_hud, my_hud.current_plane_offset)

		if("set_keybind")
			var/kb_name = params["keybind_name"]
			if(!kb_name)
				return

			var/old_key = params["old_key"]
			if(key_bindings[old_key])
				key_bindings[old_key] -= kb_name
				if(!length(key_bindings[old_key]))
					key_bindings -= old_key

			if(!params["key"])
				return
			var/mods = params["key_mods"]
			var/full_key = params["key"]
			var/Altmod = ("ALT" in mods) ? "Alt" : ""
			var/Ctrlmod = ("CONTROL" in mods) ? "Ctrl" : ""
			var/Shiftmod = ("SHIFT" in mods) ? "Shift" : ""
			full_key = Altmod + Ctrlmod + Shiftmod + full_key

			if(GLOB._kbMap[full_key])
				full_key = GLOB._kbMap[full_key]

			if(kb_name in key_bindings[full_key]) //We pressed the same key combination that was already bound here, so let's remove to re-add and re-sort.
				key_bindings[full_key] -= kb_name

			key_bindings[full_key] += list(kb_name)
			key_bindings[full_key] = sortList(key_bindings[full_key])
			current_client.set_macros()
			save_keybinds()
			if(user)
				SEND_SIGNAL(user, COMSIG_MOB_KEYBINDINGS_UPDATED, GLOB.keybindings_by_name[kb_name])
			return TRUE

		if("clear_keybind")
			var/kb_name = params["keybinding"]
			for(var/key in key_bindings)
				if(!(kb_name in key_bindings[key]))
					continue
				key_bindings[key] -= kb_name
				if(!length(key_bindings[key]))
					key_bindings -= key
					continue
				key_bindings[key] = sortList(key_bindings[key])
			current_client.set_macros()
			save_keybinds()
			return TRUE

		if("setCustomSentence")
			var/kb_name = params["name"]
			if(!kb_name)
				return
			var/list/part = splittext(kb_name, ":")
			var/id = text2num(part[2])
			var/datum/custom_emote/emote = custom_emotes[id]
			var/new_message = params["sentence"]
			if(length(new_message) > 300)
				return
			emote.message = new_message
			custom_emotes[id] = emote

		if("setEmoteType")
			var/kb_name = params["name"]
			if(!kb_name)
				return
			var/list/part = splittext(kb_name, ":")
			var/id = text2num(part[2])
			var/datum/custom_emote/emote = custom_emotes[id]
			emote.spoken_emote = !emote.spoken_emote

		if("reset-keybindings")
			key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key)
			current_client.set_macros()
			save_keybinds()

		if("bancheck")
			var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, params["role"])
			var/admin = FALSE
			if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
				admin = TRUE
			for(var/i in ban_details)
				if(admin && !text2num(i["applies_to_admins"]))
					continue
				ban_details = i
				break //we only want to get the most recent ban's details
			if(!length(ban_details))
				return

			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, span_danger("You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [params["role"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]"))

		if("widescreenpref")
			widescreenpref = !widescreenpref
			user.client.view_size.set_default(get_screen_size(widescreenpref))

		if("radialmedicalpref")
			toggles_gameplay ^= RADIAL_MEDICAL

		if("radiallasersgunpref")
			toggles_gameplay ^= RADIAL_LASERGUNS

		if("radialstackspref")
			toggles_gameplay ^= RADIAL_STACKS

		if("autointeractdeployablespref")
			toggles_gameplay ^= AUTO_INTERACT_DEPLOYABLES

		if("directional_attacks")
			toggles_gameplay ^= DIRECTIONAL_ATTACKS

		if("toggle_clickdrag")
			toggles_gameplay ^= TOGGLE_CLICKDRAG

		if("toggle_xeno_move_intent_keybind")
			toggles_gameplay ^= TOGGLE_XENO_MOVE_INTENT_KEYBIND

		if("pixel_size")
			switch(pixel_size)
				if(PIXEL_SCALING_AUTO)
					pixel_size = PIXEL_SCALING_1X
				if(PIXEL_SCALING_1X)
					pixel_size = PIXEL_SCALING_1_2X
				if(PIXEL_SCALING_1_2X)
					pixel_size = PIXEL_SCALING_2X
				if(PIXEL_SCALING_2X)
					pixel_size = PIXEL_SCALING_3X
				if(PIXEL_SCALING_3X)
					pixel_size = PIXEL_SCALING_AUTO
			user.client.view_size.apply() //Let's winset() it so it actually works

		if("parallax")
			parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
			if(parent?.mob && parent.mob.hud_used)
				parent.mob.hud_used.update_parallax_pref(parent.mob)

		if("scaling_method")
			switch(scaling_method)
				if(SCALING_METHOD_NORMAL)
					scaling_method = SCALING_METHOD_DISTORT
				if(SCALING_METHOD_DISTORT)
					scaling_method = SCALING_METHOD_BLUR
				if(SCALING_METHOD_BLUR)
					scaling_method = SCALING_METHOD_NORMAL
			user.client.view_size.update_zoom_mode()

		if("unique_action_use_active_hand")
			unique_action_use_active_hand = !unique_action_use_active_hand

		if("fast_mc_refresh")
			fast_mc_refresh = !fast_mc_refresh

		if("split_admin_tabs")
			split_admin_tabs = !split_admin_tabs

		if("hear_ooc_anywhere_as_staff")
			hear_ooc_anywhere_as_staff = !hear_ooc_anywhere_as_staff

		else //  Handle the unhandled cases
			return

	save_preferences()
	save_character()
	save_keybinds()
	ui_interact(user, ui)
	SEND_SIGNAL(current_client, COMSIG_CLIENT_PREFERENCES_UIACTED)
	return TRUE
