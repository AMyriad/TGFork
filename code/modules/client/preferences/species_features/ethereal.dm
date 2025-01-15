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
	relevant_external_organ = /obj/item/organ/internal/eyes/ethereal

/datum/preference/choiced/ethereal_mark/init_possible_values()
	return assoc_to_keys_features(SSaccessories.ethereal_mark_list)

/datum/preference/choiced/ethereal_mark/create_default_value()
	return /datum/sprite_accessory/ethereal_mark::name

/*datum/preference/choiced/ethereal_eyes/icon_for(value)
	var/datum/sprite_accessory/ethereal_mark = SSaccessories.ethereal_mark_list[value]
	var/icon/final_icon = icon(ethereal_mark.icon, "m_ETHEREAL_MARK_[ethereal_mark.icon_state]_ADJ")
	final_icon.Blend(final_icon, ICON_OVERLAY)
	return final_icon */

/datum/preference/choiced/ethereal_mark/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ethmark"] = value
