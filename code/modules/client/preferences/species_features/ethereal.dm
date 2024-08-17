/datum/preference/choiced/ethereal_color
	savefile_key = "feature_ethcolor"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Ethereal color"
	should_generate_icons = TRUE

/datum/preference/choiced/ethereal_color/init_possible_values()
	return assoc_to_keys(GLOB.color_list_ethereal)

/datum/preference/choiced/ethereal_color/icon_for(value)
	var/static/icon/ethereal_base
	if (isnull(ethereal_base))
		ethereal_base = icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_head")
		ethereal_base.Blend(icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_chest"), ICON_OVERLAY)
		ethereal_base.Blend(icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_l_arm"), ICON_OVERLAY)
		ethereal_base.Blend(icon('icons/mob/human/species/ethereal/bodyparts.dmi', "ethereal_r_arm"), ICON_OVERLAY)

		var/icon/eyes = icon('icons/mob/human/human_face.dmi', "eyes")
		eyes.Blend(COLOR_BLACK, ICON_MULTIPLY)
		ethereal_base.Blend(eyes, ICON_OVERLAY)

		ethereal_base.Scale(64, 64)
		ethereal_base.Crop(15, 64, 15 + 31, 64 - 31)

	var/icon/icon = new(ethereal_base)
	icon.Blend(GLOB.color_list_ethereal[value], ICON_MULTIPLY)
	return icon

/datum/preference/choiced/ethereal_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ethcolor"] = GLOB.color_list_ethereal[value]

/datum/preference/choiced/ethereal_mark
	savefile_key = "feature_ethmark"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Ethereal mark"
	should_generate_icons = TRUE
	relevant_body_markings = /datum/bodypart_overlay/simple/body_marking/ethereal

/datum/preference/choiced/ethereal_mark/init_possible_values()
	return assoc_to_keys_features(SSaccessories.ethereal_mark_list)

/datum/preference/choiced/ethereal_mark/icon_for(value)
	var/static/list/body_parts = list(
		/obj/item/bodypart/head/ethereal
	)

	var/static/icon/ethereal_mark
	if (isnull(ethereal_mark))
		ethereal_mark = icon('icons/blanks/32x32.dmi', "nothing")

		ethereal_mark.Blend(icon('icons/mob/human/species/moth/moth_wings.dmi', "m_moth_wings_plain_BEHIND"), ICON_OVERLAY)

		for (var/obj/item/bodypart/body_part as anything in body_parts)
			ethereal_mark.Blend(icon('icons/mob/human/species/moth/bodyparts.dmi', initial(body_part.icon_state)), ICON_OVERLAY)

		ethereal_mark.Blend(icon('icons/mob/human/human_face.dmi', "motheyes_l"), ICON_OVERLAY)
		ethereal_mark.Blend(icon('icons/mob/human/human_face.dmi', "motheyes_r"), ICON_OVERLAY)

	var/datum/sprite_accessory/markings = SSaccessories.moth_markings_list[value]
	var/icon/icon_with_markings = new(ethereal_mark)

	if (value != "None")
		for (var/obj/item/bodypart/body_part as anything in body_parts)
			var/icon/body_part_icon = icon(markings.icon, "[markings.icon_state]_[initial(body_part.body_zone)]")
			body_part_icon.Crop(1, 1, 32, 32)
			icon_with_markings.Blend(body_part_icon, ICON_OVERLAY)

	icon_with_markings.Blend(icon('icons/mob/human/species/moth/moth_wings.dmi', "m_moth_wings_plain_FRONT"), ICON_OVERLAY)
	icon_with_markings.Blend(icon('icons/mob/human/species/moth/moth_antennae.dmi', "m_moth_antennae_plain_FRONT"), ICON_OVERLAY)

	// Zoom in on the top of the head and the chest
	icon_with_markings.Scale(64, 64)
	icon_with_markings.Crop(15, 64, 15 + 31, 64 - 31)

	return icon_with_markings

/datum/preference/choiced/moth_markings/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["moth_markings"] = value
