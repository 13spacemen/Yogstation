/datum/species/vox
	name = "Vox"
	id = SPECIES_VOX
	is_dimorphic = FALSE
	generate_husk_icon = TRUE
	species_traits = list(NOTRANSSTING, EYECOLOR, HAS_TAIL, HAS_FLESH, HAS_BONE, HAIRCOLOR, FACEHAIRCOLOR, MUTCOLORS, MUTCOLORS_SECONDARY) // Robust, but cannot be cloned easily.
	inherent_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_NOCLONE)
	mutant_bodyparts = list("vox_quills", "vox_body_markings", "vox_facial_quills", "vox_tail", "vox_tail_markings")
	default_features = list("vox_quills" = "None", "vox_facial_quills" = "None", "vox_body_markings" = "None", "vox_tail" = "green", "vox_tail_markings" = "None", "vox_skin_tone" = "green")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	screamsound = 'sound/voice/vox/shriek1.ogg'
	cough_sound = 'sound/voice/vox/shriekcough.ogg'
	sneeze_sound = 'sound/voice/vox/shrieksneeze.ogg'
	mutantbrain = /obj/item/organ/brain/vox // Brain damage on EMP
	mutantheart = /obj/item/organ/heart/vox
	mutantliver = /obj/item/organ/liver/vox // Liver damage on EMP
	mutantstomach = /obj/item/organ/stomach/vox // Disgust on EMP
	mutanttongue = /obj/item/organ/tongue/vox
	mutantlungs = /obj/item/organ/lungs/vox // Causes them to.. gasp.
	mutantears = /obj/item/organ/ears/vox // Very brief deafness
	mutanteyes = /obj/item/organ/eyes/vox // Quick hallucination
	mutanttail = /obj/item/organ/tail/vox
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/vox
	skinned_type = /obj/item/stack/sheet/animalhide/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	toxmod = 2 // Weak immune systems.
	burnmod = 0.8 // Tough hides.
	stunmod = 1.1 // Take a bit longer to get up than other species.
	breathid = "n2"
	suicide_messages = list(
		"is jamming their claws into their eye sockets!",
		"is deeply inhaling oxygen!")
	husk_color = null
	eyes_icon = 'icons/mob/species/vox/eyes.dmi'
	icon_husk = 'icons/mob/species/vox/bodyparts.dmi'
	limb_icon_file = 'icons/mob/species/vox/bodyparts.dmi'
	static_part_body_zones = list(BODY_ZONE_HEAD, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	parts_to_husk = list("vox_tail", "vox_tail_markings", "wagging_vox_tail", "wagging_vox_tail_markings", "vox_body_markings")
	damage_overlay_type = "vox"
	exotic_bloodtype = "V"

/datum/species/vox/get_species_description()
	return "The Vox are remnants of an ancient race, that originate from arkships. \
	These bioengineered, reptilian, beaked, and quilled beings have a physiological caste system and follow 'The Inviolate' tenets.<br/><br/> \
	Breathing pure nitrogen, they need specialized masks and tanks for survival outside their arkships. \
	Their insular nature limits their involvement in broader galactic affairs, maintaining a distinct, yet isolated presence away from other species."
	
/datum/species/vox/get_species_lore()
	return list("imma be real witchu chief...i aint got any lore")

/datum/species/vox/random_name(unique)
	if(unique)
		return random_unique_vox_name()
	return capitalize(vox_name())

/datum/species/vox/after_equip_job(datum/job/J, mob/living/carbon/human/H) // Don't forget your voxygen tank
	H.grant_language(/datum/language/vox)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/breath/vox/respirator(H), ITEM_SLOT_MASK)
	var/obj/item/tank/internal_tank
	var/tank_pref = H.client?.prefs?.read_preference(/datum/preference/choiced/vox_tank_type)
	if(tank_pref == "Large N² Tank")
		internal_tank = new /obj/item/tank/internals/nitrogen
	else
		internal_tank = new /obj/item/tank/internals/emergency_oxygen/vox
	H.put_in_r_hand(internal_tank)
	to_chat(H, span_notice("You are now running on nitrogen internals from [internal_tank]. Your species finds oxygen toxic, so you must breathe nitrogen only."))
	H.open_internals(H.get_item_for_held_index(2))
	H.grant_language(/datum/language/vox)

/datum/species/vox/get_icon_variant(mob/living/carbon/person_to_check)
	return person_to_check.dna.features["vox_skin_tone"]

/datum/species/vox/handle_body(mob/living/carbon/human/H)
	update_skin_tone(vox = H)
	..()

/datum/species/vox/proc/update_skin_tone(skin_tone, mob/living/carbon/human/vox)
	if(!skin_tone)
		skin_tone = vox.dna.features["vox_skin_tone"]
	vox.dna.features["vox_skin_tone"] = skin_tone
	var/obj/item/organ/tail/vox/vox_tail = vox.getorganslot(ORGAN_SLOT_TAIL)
	if(vox == vox_tail?.original_owner)
		vox_tail.tail_type = skin_tone

/datum/species/vox/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "temperature-low",
			SPECIES_PERK_NAME = "Cold Resistance",
			SPECIES_PERK_DESC = "Vox have their organs heavily modified to resist the coldness of space",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "bolt",
			SPECIES_PERK_NAME = "EMP Sensitivity",
			SPECIES_PERK_DESC = "Due to their organs being synthetic, they are susceptible to emps.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "wind",
			SPECIES_PERK_NAME = "Nitrogen Breathing",
			SPECIES_PERK_DESC = "Vox must breathe nitrogen to survive. You receive a tank when you arrive.",
		),
	)

	return to_add
