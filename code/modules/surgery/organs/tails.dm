// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"
	visual = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	compatible_biotypes = ALL_BIOTYPES // pretty much entirely cosmetic, if someone wants to make crimes against nature then sure
	/// The sprite accessory this tail gives to the human it's attached to. If null, it will inherit its value from the human's DNA once attached.
	var/tail_type = "None"

/obj/item/organ/tail/Remove(mob/living/carbon/human/H, special = 0)
	..()
	if(H && H.dna && H.dna.species)
		H.dna.species.stop_wagging_tail(H)

/obj/item/organ/tail/get_availability(datum/species/species)
	return (HAS_TAIL in species.species_traits)

/obj/item/organ/tail/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"
	tail_type = "Cat"

/obj/item/organ/tail/cat/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		var/default_part = H.dna.species.mutant_bodyparts["tail_human"]
		if(!default_part || default_part == "None")
			if(tail_type)
				H.dna.features["tail_human"] = H.dna.species.mutant_bodyparts["tail_human"] = tail_type
				H.dna.update_uf_block(DNA_HUMAN_TAIL_BLOCK)
			else
				H.dna.species.mutant_bodyparts["tail_human"] = H.dna.features["tail_human"]
		H.update_body()

/obj/item/organ/tail/cat/Remove(mob/living/carbon/human/H, special = 0)
	..()
	if(istype(H))
		H.dna.species.mutant_bodyparts -= "tail_human"
		color = H.hair_color
		H.update_body()

/obj/item/organ/tail/lizard
	name = "lizard tail"
	desc = "A severed lizard tail. Somewhere, no doubt, a lizard hater is very pleased with themselves."
	icon_state = "severedlizardtail" //yogs - so the tail uses the correct sprites
	color = "#116611"
	tail_type = "Smooth"
	var/spines = "None"

/obj/item/organ/tail/lizard/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		// Checks here are necessary so it wouldn't overwrite the tail of a lizard it spawned in
		var/default_part = H.dna.species.mutant_bodyparts["tail_lizard"]
		if(!default_part || default_part == "None")
			if(tail_type)
				H.dna.features["tail_lizard"] = H.dna.species.mutant_bodyparts["tail_lizard"] = tail_type
				H.dna.update_uf_block(DNA_LIZARD_TAIL_BLOCK)
			else
				H.dna.species.mutant_bodyparts["tail_lizard"] = H.dna.features["tail_lizard"]
		
		default_part = H.dna.species.mutant_bodyparts["spines"]
		if(!default_part || default_part == "None")
			if(spines)
				H.dna.features["spines"] = H.dna.species.mutant_bodyparts["spines"] = spines
				H.dna.update_uf_block(DNA_SPINES_BLOCK)
			else
				H.dna.species.mutant_bodyparts["spines"] = H.dna.features["spines"]
		H.update_body()

/obj/item/organ/tail/lizard/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.species.mutant_bodyparts -= "tail_lizard"
		H.dna.species.mutant_bodyparts -= "spines"
		color = H.dna.features["mcolor"]
		tail_type = H.dna.features["tail_lizard"]
		spines = H.dna.features["spines"]
		H.update_body()

/obj/item/organ/tail/lizard/fake
	name = "fabricated lizard tail"
	desc = "A fabricated severed lizard tail. This one's made of synthflesh. Probably not usable for lizard wine."

/obj/item/organ/tail/polysmorph
	name = "polysmorph tail"
	desc = "A severed polysmorph tail."
	icon_state = "severedpolytail" //yogs - so the tail uses the correct sprites
	tail_type = "Polys"

/obj/item/organ/tail/polysmorph/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = FALSE)
	..()
	if(istype(H))
		var/default_part = H.dna.species.mutant_bodyparts["tail_polysmorph"]
		if(!default_part || default_part == "None")
			if(tail_type)
				H.dna.features["tail_polysmorph"] = H.dna.species.mutant_bodyparts["tail_polysmorph"] = tail_type
				H.dna.update_uf_block(DNA_POLY_TAIL_BLOCK)
			else
				H.dna.species.mutant_bodyparts["tail_polysmorph"] = H.dna.features["tail_polysmorph"]
		H.update_body()
		if(H.physiology)
			H.physiology.crawl_speed += 0.5

/obj/item/organ/tail/polysmorph/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.species.mutant_bodyparts -= "tail_polysmorph"
		tail_type = H.dna.features["tail_polysmorph"]
		H.update_body()
		if(H.physiology)
			H.physiology.crawl_speed -= 0.5

/obj/item/organ/tail/vox
	name = "vox tail"
	desc = "A severed vox tail. Somewhere, no doubt, a vox hater is very pleased with themselves."
	icon = 'icons/mob/species/vox/tails.dmi'
	icon_state = "m_tail_green_BEHIND"
	tail_type = "green"
	var/icon_state_text = "m_tail_green"
	var/icon/constructed_tail_icon
	var/tail_markings = "None"
	var/tail_markings_color
	var/original_owner

/obj/item/organ/tail/vox/Initialize(mapload)
	. = ..()
	set_icon_state()

/obj/item/organ/tail/vox/proc/set_icon_state()
	icon_state_text = "m_tail_[tail_type]"
	icon_state = "[icon_state_text]_BEHIND"
	constructed_tail_icon = icon(initial(icon), icon_state)
	var/icon/constructed_tail_icon_north = icon(constructed_tail_icon, dir = SOUTH)
	constructed_tail_icon_north.Turn(180)
	constructed_tail_icon.Insert(constructed_tail_icon_north, dir = NORTH)
	if(tail_markings && tail_markings != "None")
		var/datum/sprite_accessory/vox_tail_markings/vox_markings = GLOB.vox_tail_markings_list[tail_markings]
		var/vox_markings_state_text = "m_vox_tail_markings_[vox_markings.icon_state]"
		var/icon/constructed_markings = icon(vox_markings.icon, "[vox_markings_state_text]_BEHIND")
		var/icon/constructed_markings_north = icon(constructed_markings, dir = SOUTH)
		constructed_markings_north.Turn(180)
		constructed_markings.Insert(constructed_markings_north, dir = NORTH)
		constructed_markings.Blend(tail_markings_color, ICON_ADD)
		constructed_tail_icon.Blend(constructed_markings, ICON_OVERLAY)
	icon = constructed_tail_icon

/obj/item/organ/tail/vox/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		if(!original_owner)
			original_owner = H
		var/default_part = H.dna.species.mutant_bodyparts["vox_tail"]
		if(!default_part || default_part == "None")
			if(original_owner != H)
				H.dna.species.mutant_bodyparts["vox_tail"] = tail_type
			else
				tail_type = H.dna.species.mutant_bodyparts["vox_tail"] = H.dna.features["vox_skin_tone"]
		
		default_part = H.dna.species.mutant_bodyparts["vox_tail_markings"]
		if(!default_part || default_part == "None")
			if(original_owner != H)
				H.dna.species.mutant_bodyparts["vox_tail_markings"] = tail_markings
			else
				tail_markings = H.dna.species.mutant_bodyparts["vox_tail_markings"] = H.dna.features["vox_tail_markings"]
		H.update_body()

/obj/item/organ/tail/vox/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.species.mutant_bodyparts -= "vox_tail"
		H.dna.species.mutant_bodyparts -= "vox_tail_markings"
		update_tail_appearance(H)
		set_icon_state()
		H.update_body()

/obj/item/organ/tail/vox/proc/update_tail_appearance(mob/living/carbon/human/tail_owner)
	if(original_owner && original_owner != tail_owner)
		return
	tail_type = tail_owner.dna.features["vox_skin_tone"]
	tail_markings = tail_owner.dna.features["vox_tail_markings"]
	tail_markings_color = tail_owner.dna.features["mcolor_secondary"]

/obj/item/organ/tail/vox/fake
	name = "fabricated vox tail"
	desc = "A fabricated severed vox tail. This one's made of synthflesh."

