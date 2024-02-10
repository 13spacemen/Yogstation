/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats/hats.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	/// Can land on someones head
	var/hattable = TRUE
	dynamic_hair_suffix = "+generic"
	sprite_sheets = list("Vox" = VOX_HEAD_FILE)

/obj/item/clothing/head/Initialize(mapload)
	. = ..()
	if(ishuman(loc) && dynamic_hair_suffix)
		var/mob/living/carbon/human/H = loc
		H.update_hair()

/obj/item/clothing/head/worn_overlays(isinhands = FALSE)
	. = ..()
	if(isinhands)
		return

	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedhelmet")

	if(!HAS_BLOOD_DNA(src))
		return

	var/mutable_appearance/bloody_helmet
	if(clothing_flags & LARGE_WORN_ICON)
		bloody_helmet = mutable_appearance('icons/effects/64x64.dmi', "helmetblood_large")
	else
		bloody_helmet = mutable_appearance('icons/effects/blood.dmi', "helmetblood")
	bloody_helmet.color = get_blood_dna_color(return_blood_DNA())
	. += bloody_helmet

/obj/item/clothing/head/update_clothes_damaged_state()
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_head()

/obj/item/clothing/head/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!hattable)
		return
	if(throwingdatum?.thrower?.zone_selected != BODY_ZONE_HEAD && throwingdatum?.thrower?.a_intent != INTENT_HELP)
		return
	if(ishuman(hit_atom))
		var/mob/living/carbon/human/H = hit_atom
		if(prob(33) && H.equip_to_slot_if_possible(src, ITEM_SLOT_HEAD))
			H.visible_message("The [src] lands gracefully on [H]'s head")
			return TRUE
		H.visible_message("The [src] hits [H]'s head")
	