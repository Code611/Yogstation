/obj/item/organ/eyes/preternis
	name = "preternis eyes"
	desc = "An experimental upgraded version of eyes that can see in the dark.They are designed to fit preternis"
	see_in_dark = PRETERNIS_NV_ON
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	actions_types = list(/datum/action/item_action/organ_action/use)
	var/night_vision = TRUE

/obj/item/organ/eyes/preternis/ui_action_click()
	var/datum/species/preternis/S = owner.dna.species
	if(S.charge < PRETERNIS_LEVEL_FED)
		return
	sight_flags = initial(sight_flags)
	switch(lighting_alpha)
		if (LIGHTING_PLANE_ALPHA_VISIBLE)
			lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
		if (LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE)
			lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
		if (LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE)
			lighting_alpha = LIGHTING_PLANE_ALPHA_INVISIBLE
		else
			lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
			sight_flags &= ~SEE_BLACKNESS
	owner.update_sight()

/obj/item/organ/eyes/preternis/on_life()
	. = ..()
	if(!ispreternis(owner))
		qdel(src) //these eyes depend on being inside a preternis
		return
	var/datum/species/preternis/S = owner.dna.species
	if(S.charge >= PRETERNIS_LEVEL_FED)
		if(see_in_dark == PRETERNIS_NV_OFF)
			see_in_dark = PRETERNIS_NV_ON
			owner.update_sight()
	else
		if(see_in_dark == PRETERNIS_NV_ON)
			see_in_dark = PRETERNIS_NV_OFF
			owner.update_sight()
		if(lighting_alpha < LIGHTING_PLANE_ALPHA_VISIBLE)
			lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
			sight_flags &= ~SEE_BLACKNESS
			owner.update_sight()

/obj/item/organ/lungs/preternis
	name = "preternis lungs"
	desc = "An experimental set of lungs.Due to the cybernetic nature of these lungs,they are less resistant to heat and cold but are more efficent at filtering oxygen."
	icon_state = "lungs-c"
	gas_stimulation_min = 0.1 //fucking filters removing my stimulants this is so cringe can we NEVER HAVE THIS FEATURE,ALEXKAR YOU FAT FUCKING WHORE WHO USES STIMULIUM LITERALLY WH
	heat_level_1_threshold = 320
	heat_level_2_threshold = 400
	heat_level_3_threshold = 600 //HALP MY LUNGS ARE ON FIRE+fuck cold because monstermos and its consequences for the human race have been a disaster for preternis.
