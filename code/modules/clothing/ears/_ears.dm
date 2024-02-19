
//Ears: currently only used for headsets and earmuffs
/obj/item/clothing/ears
	name = "ears"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	slot_flags = ITEM_SLOT_EARS
	resistance_flags = NONE
	sprite_sheets = list(SPECIES_VOX = VOX_EARS_FILE)

/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	item_state = "earmuffs"
	strip_delay = 15
	equip_delay_other = 25
	resistance_flags = FLAMMABLE
	custom_price = 40

/obj/item/clothing/ears/earmuffs/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/earhealing)
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/clothing/ears/headphones
	name = "headphones"
	desc = "Unce unce unce unce. Boop!"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "headphones"
	item_state = "headphones"
	slot_flags = ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_NECK		//Fluff item, put it whereever you want!
	actions_types = list(/datum/action/item_action/toggle_headphones)
	var/headphones_on = FALSE
	custom_price = 20

/obj/item/clothing/ears/headphones/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/item/clothing/ears/headphones/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[headphones_on? "on" : "off"]"
	item_state = "[initial(item_state)]_[headphones_on? "on" : "off"]"

/obj/item/clothing/ears/headphones/proc/toggle(owner)
	headphones_on = !headphones_on
	update_appearance(UPDATE_ICON)
	var/mob/living/carbon/human/H = owner
	if(istype(H))
		H.update_inv_ears()
		H.update_inv_neck()
		H.update_inv_head()
	to_chat(owner, span_notice("You turn the music [headphones_on? "on. Untz Untz Untz!" : "off."]"))
