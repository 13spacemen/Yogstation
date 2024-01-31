/*

	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl


	Notice: This all gets automatically compiled in a list in dna.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/
/proc/init_sprite_accessory_subtypes(prototype, list/L, list/male, list/female, roundstart = FALSE)//Roundstart argument builds a specific list for roundstart parts where some parts may be locked
	if(!istype(L))
		L = list()
	if(!istype(male))
		male = list()
	if(!istype(female))
		female = list()

	for(var/path in typesof(prototype))
		if(path == prototype)
			continue
		if(roundstart)
			var/datum/sprite_accessory/P = path
			if(initial(P.locked))
				continue
		var/datum/sprite_accessory/D = new path()

		if(D.icon_state)
			L[D.name] = D
		else
			L += D.name

		switch(D.gender)
			if(MALE)
				male += D.name
			if(FEMALE)
				female += D.name
			else
				male += D.name
				female += D.name
	return L

/datum/sprite_accessory
	var/icon			//the icon file the accessory is located in
	var/icon_state		//the icon_state of the accessory
	var/name			//the preview name of the accessory
	var/gender = NEUTER	//Determines if the accessory will be skipped or included in random hair generations
	var/gender_specific //Something that can be worn by either gender, but looks different on each
	var/color_src = MUTCOLORS	//Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
	var/hasinner		//Decides if this sprite has an "inner" part, such as the fleshy parts on ears.
	var/locked = FALSE		//Is this part locked from roundstart selection? Used for parts that apply effects
	var/dimension_x = 32
	var/dimension_y = 32
	var/limbs_id // The limbs id supplied for full-body replacing features.
	var/center = FALSE	//Should we center the sprite?
	var/emissive = FALSE //is this emissive?
	var/color_blend_mode = "multiply"
	///the body slots outside of the main slot this accessory exists in, so we can draw to those spots seperately
	var/list/body_slots = list()
	/// the list of external organs covered
	var/list/external_slots = list()
	var/list/sprite_sheets = list() //For accessories common across species but need to use 'fitted' sprites (like underwear). e.g. list("Vox" = 'icons/mob/species/vox/iconfile.dmi')


//////////////////////
// Hair Definitions //
//////////////////////
/datum/sprite_accessory/hair
	icon = 'icons/mob/human_face.dmi'	  // default icon for all hairs

	// please make sure they're sorted alphabetically and, where needed, categorized
	// try to capitalize the names please~
	// try to spell
	// you do not need to define _s or _l sub-states, game automatically does this for you

/datum/sprite_accessory/hair/afro
	name = "Afro"
	icon_state = "hair_afro"

/datum/sprite_accessory/hair/afro2
	name = "Afro 2"
	icon_state = "hair_afro2"

/datum/sprite_accessory/hair/afro_large
	name = "Afro (Large)"
	icon_state = "hair_bigafro"

/datum/sprite_accessory/hair/antenna
	name = "Ahoge"
	icon_state = "hair_antenna"

/datum/sprite_accessory/hair/bald
	name = "Bald"
	icon_state = null

/datum/sprite_accessory/hair/balding
	name = "Balding Hair"
	icon_state = "hair_e"

/datum/sprite_accessory/hair/bedhead
	name = "Bedhead"
	icon_state = "hair_bedhead"

/datum/sprite_accessory/hair/bedhead2
	name = "Bedhead 2"
	icon_state = "hair_bedheadv2"

/datum/sprite_accessory/hair/bedhead3
	name = "Bedhead 3"
	icon_state = "hair_bedheadv3"

/datum/sprite_accessory/hair/bedheadlong
	name = "Long Bedhead"
	icon_state = "hair_long_bedhead"

/datum/sprite_accessory/hair/bedheadfloorlength
	name = "Floorlength Bedhead"
	icon_state = "hair_floorlength_bedhead"

/datum/sprite_accessory/hair/beehive
	name = "Beehive"
	icon_state = "hair_beehive"

/datum/sprite_accessory/hair/beehive2
	name = "Beehive 2"
	icon_state = "hair_beehivev2"

/datum/sprite_accessory/hair/bob
	name = "Bob Hair"
	icon_state = "hair_bob"

/datum/sprite_accessory/hair/bob2
	name = "Bob Hair 2"
	icon_state = "hair_bob2"

/datum/sprite_accessory/hair/bob3
	name = "Bob Hair 3"
	icon_state = "hair_bobcut"

/datum/sprite_accessory/hair/bob4
	name = "Bob Hair 4"
	icon_state = "hair_bob4"

/datum/sprite_accessory/hair/bobcurl
	name = "Bobcurl"
	icon_state = "hair_bobcurl"

/datum/sprite_accessory/hair/boddicker
	name = "Boddicker"
	icon_state = "hair_boddicker"

/datum/sprite_accessory/hair/bowlcut
	name = "Bowlcut"
	icon_state = "hair_bowlcut"

/datum/sprite_accessory/hair/bowlcut2
	name = "Bowlcut 2"
	icon_state = "hair_bowlcut2"

/datum/sprite_accessory/hair/braid
	name = "Braid (Floorlength)"
	icon_state = "hair_braid"

/datum/sprite_accessory/hair/braided
	name = "Braided"
	icon_state = "hair_braided"

/datum/sprite_accessory/hair/front_braid
	name = "Braided Front"
	icon_state = "hair_braidfront"

/datum/sprite_accessory/hair/not_floorlength_braid
	name = "Braid (High)"
	icon_state = "hair_braid2"

/datum/sprite_accessory/hair/lowbraid
	name = "Braid (Low)"
	icon_state = "hair_hbraid"

/datum/sprite_accessory/hair/shortbraid
	name = "Braid (Short)"
	icon_state = "hair_shortbraid"

/datum/sprite_accessory/hair/braidtail
	name = "Braided Tail"
	icon_state = "hair_braidtail"

/datum/sprite_accessory/hair/bun
	name = "Bun Head"
	icon_state = "hair_bun"

/datum/sprite_accessory/hair/bun2
	name = "Bun Head 2"
	icon_state = "hair_bunhead2"

/datum/sprite_accessory/hair/bun3
	name = "Bun Head 3"
	icon_state = "hair_bun3"

/datum/sprite_accessory/hair/largebun
	name = "Bun (Large)"
	icon_state = "hair_largebun"

/datum/sprite_accessory/hair/manbun
	name = "Bun (Manbun)"
	icon_state = "hair_manbun"

/datum/sprite_accessory/hair/tightbun
	name = "Bun (Tight)"
	icon_state = "hair_tightbun"

/datum/sprite_accessory/hair/business
	name = "Business Hair"
	icon_state = "hair_business"

/datum/sprite_accessory/hair/business2
	name = "Business Hair 2"
	icon_state = "hair_business2"

/datum/sprite_accessory/hair/business3
	name = "Business Hair 3"
	icon_state = "hair_business3"

/datum/sprite_accessory/hair/business4
	name = "Business Hair 4"
	icon_state = "hair_business4"

/datum/sprite_accessory/hair/buzz
	name = "Buzzcut"
	icon_state = "hair_buzzcut"

/datum/sprite_accessory/hair/cia
	name = "CIA"
	icon_state = "hair_cia"

/datum/sprite_accessory/hair/coffeehouse
	name = "Coffee House"
	icon_state = "hair_coffeehouse"

/datum/sprite_accessory/hair/combover
	name = "Combover"
	icon_state = "hair_combover"

/datum/sprite_accessory/hair/cornrows1
	name = "Cornrows"
	icon_state = "hair_cornrows"

/datum/sprite_accessory/hair/cornrows2
	name = "Cornrows 2"
	icon_state = "hair_cornrows2"

/datum/sprite_accessory/hair/cornrowbun
	name = "Cornrow Bun"
	icon_state = "hair_cornrowbun"

/datum/sprite_accessory/hair/cornrowbraid
	name = "Cornrow Braid"
	icon_state = "hair_cornrowbraid"

/datum/sprite_accessory/hair/cornrowdualtail
	name = "Cornrow Tail"
	icon_state = "hair_cornrowtail"

/datum/sprite_accessory/hair/crew
	name = "Crewcut"
	icon_state = "hair_crewcut"

/datum/sprite_accessory/hair/curls
	name = "Curls"
	icon_state = "hair_curls"

/datum/sprite_accessory/hair/cut
	name = "Cut Hair"
	icon_state = "hair_c"

/datum/sprite_accessory/hair/dandpompadour
	name = "Dandy Pompadour"
	icon_state = "hair_dandypompadour"

/datum/sprite_accessory/hair/devillock
	name = "Devil Lock"
	icon_state = "hair_devilock"

/datum/sprite_accessory/hair/doublebun
	name = "Double Bun"
	icon_state = "hair_doublebun"

/datum/sprite_accessory/hair/dreadlocks
	name = "Dreadlocks"
	icon_state = "hair_dreads"

/datum/sprite_accessory/hair/drillhair
	name = "Drill Hair"
	icon_state = "hair_drillhair"

/datum/sprite_accessory/hair/drillhairruru
	name = "Drillruru"
	icon_state = "hair_drillruru"

/datum/sprite_accessory/hair/drillhairextended
	name = "Drill Hair (Extended)"
	icon_state = "hair_drillhairextended"

/datum/sprite_accessory/hair/emo
	name = "Emo"
	icon_state = "hair_emo"

/datum/sprite_accessory/hair/emofrine
	name = "Emo Fringe"
	icon_state = "hair_emofringe"

/datum/sprite_accessory/hair/nofade
	name = "Fade (None)"
	icon_state = "hair_nofade"

/datum/sprite_accessory/hair/highfade
	name = "Fade (High)"
	icon_state = "hair_highfade"

/datum/sprite_accessory/hair/medfade
	name = "Fade (Medium)"
	icon_state = "hair_medfade"

/datum/sprite_accessory/hair/lowfade
	name = "Fade (Low)"
	icon_state = "hair_lowfade"

/datum/sprite_accessory/hair/baldfade
	name = "Fade (Bald)"
	icon_state = "hair_baldfade"

/datum/sprite_accessory/hair/feather
	name = "Feather"
	icon_state = "hair_feather"

/datum/sprite_accessory/hair/father
	name = "Father"
	icon_state = "hair_father"

/datum/sprite_accessory/hair/sargeant
	name = "Flat Top"
	icon_state = "hair_sargeant"

/datum/sprite_accessory/hair/flair
	name = "Flair"
	icon_state = "hair_flair"

/datum/sprite_accessory/hair/bigflattop
	name = "Flat Top (Big)"
	icon_state = "hair_bigflattop"

/datum/sprite_accessory/hair/flow
	name = "Flow Hair"
	icon_state = "hair_f"

/datum/sprite_accessory/hair/gelled
	name = "Gelled Back"
	icon_state = "hair_gelled"

/datum/sprite_accessory/hair/gentle
	name = "Gentle"
	icon_state = "hair_gentle"

/datum/sprite_accessory/hair/halfbang
	name = "Half-banged Hair"
	icon_state = "hair_halfbang"

/datum/sprite_accessory/hair/halfbang2
	name = "Half-banged Hair 2"
	icon_state = "hair_halfbang2"

/datum/sprite_accessory/hair/halfshaved
	name = "Half-shaved"
	icon_state = "hair_halfshaved"

/datum/sprite_accessory/hair/hedgehog
	name = "Hedgehog Hair"
	icon_state = "hair_hedgehog"

/datum/sprite_accessory/hair/himecut
	name = "Hime Cut"
	icon_state = "hair_himecut"

/datum/sprite_accessory/hair/himecut2
	name = "Hime Cut 2"
	icon_state = "hair_himecut2"

/datum/sprite_accessory/hair/shorthime
	name = "Hime Cut (Short)"
	icon_state = "hair_shorthime"

/datum/sprite_accessory/hair/himeup
	name = "Hime Updo"
	icon_state = "hair_himeup"

/datum/sprite_accessory/hair/hitop
	name = "Hitop"
	icon_state = "hair_hitop"

/datum/sprite_accessory/hair/jade
	name = "Jade"
	icon_state = "hair_jade"

/datum/sprite_accessory/hair/jensen
	name = "Jensen Hair"
	icon_state = "hair_jensen"

/datum/sprite_accessory/hair/Joestar
	name = "Joestar"
	icon_state = "hair_joestar"

/datum/sprite_accessory/hair/keanu
	name = "Keanu Hair"
	icon_state = "hair_keanu"

/datum/sprite_accessory/hair/kusangi
	name = "Kusanagi Hair"
	icon_state = "hair_kusanagi"

/datum/sprite_accessory/hair/long
	name = "Long Hair 1"
	icon_state = "hair_long"

/datum/sprite_accessory/hair/long2
	name = "Long Hair 2"
	icon_state = "hair_long2"

/datum/sprite_accessory/hair/long3
	name = "Long Hair 3"
	icon_state = "hair_long3"

/datum/sprite_accessory/hair/long_over_eye
	name = "Long Over Eye"
	icon_state = "hair_longovereye"

/datum/sprite_accessory/hair/longbangs
	name = "Long Bangs"
	icon_state = "hair_lbangs"

/datum/sprite_accessory/hair/longemo
	name = "Long Emo"
	icon_state = "hair_longemo"

/datum/sprite_accessory/hair/longfringe
	name = "Long Fringe"
	icon_state = "hair_longfringe"

/datum/sprite_accessory/hair/sidepartlongalt
	name = "Long Side Part"
	icon_state = "hair_longsidepart"

/datum/sprite_accessory/hair/megaeyebrows
	name = "Mega Eyebrows"
	icon_state = "hair_megaeyebrows"

/datum/sprite_accessory/hair/messy
	name = "Messy"
	icon_state = "hair_messy"

/datum/sprite_accessory/hair/modern
	name = "Modern"
	icon_state = "hair_modern"

/datum/sprite_accessory/hair/mohawk
	name = "Mohawk"
	icon_state = "hair_d"

/datum/sprite_accessory/hair/nitori
	name = "Nitori"
	icon_state = "hair_nitori"

/datum/sprite_accessory/hair/reversemohawk
	name = "Mohawk (Reverse)"
	icon_state = "hair_reversemohawk"

/datum/sprite_accessory/hair/shavedmohawk
	name = "Mohawk (Shaved)"
	icon_state = "hair_shavedmohawk"

/datum/sprite_accessory/hair/unshavedmohawk
	name = "Mohawk (Unshaven)"
	icon_state = "hair_unshaven_mohawk"

/datum/sprite_accessory/hair/mulder
	name = "Mulder"
	icon_state = "hair_mulder"

/datum/sprite_accessory/hair/odango
	name = "Odango"
	icon_state = "hair_odango"

/datum/sprite_accessory/hair/ombre
	name = "Ombre"
	icon_state = "hair_ombre"

/datum/sprite_accessory/hair/oneshoulder
	name = "One Shoulder"
	icon_state = "hair_oneshoulder"

/datum/sprite_accessory/hair/over_eye
	name = "Over Eye"
	icon_state = "hair_shortovereye"

/datum/sprite_accessory/hair/oxton
	name = "Oxton"
	icon_state = "hair_oxton"

/datum/sprite_accessory/hair/parted
	name = "Parted"
	icon_state = "hair_parted"

/datum/sprite_accessory/hair/partedside
	name = "Parted (Side)"
	icon_state = "hair_part"

/datum/sprite_accessory/hair/kagami
	name = "Pigtails"
	icon_state = "hair_kagami"

/datum/sprite_accessory/hair/pigtail
	name = "Pigtails 2"
	icon_state = "hair_pigtails"

/datum/sprite_accessory/hair/pigtail2
	name = "Pigtails 3"
	icon_state = "hair_pigtails2"

/datum/sprite_accessory/hair/pixie
	name = "Pixie Cut"
	icon_state = "hair_pixie"

/datum/sprite_accessory/hair/pompadour
	name = "Pompadour"
	icon_state = "hair_pompadour"

/datum/sprite_accessory/hair/bigpompadour
	name = "Pompadour (Big)"
	icon_state = "hair_bigpompadour"

/datum/sprite_accessory/hair/ponytail1
	name = "Ponytail"
	icon_state = "hair_ponytail"

/datum/sprite_accessory/hair/ponytail2
	name = "Ponytail 2"
	icon_state = "hair_ponytail2"

/datum/sprite_accessory/hair/ponytail3
	name = "Ponytail 3"
	icon_state = "hair_ponytail3"

/datum/sprite_accessory/hair/ponytail4
	name = "Ponytail 4"
	icon_state = "hair_ponytail4"

/datum/sprite_accessory/hair/ponytail5
	name = "Ponytail 5"
	icon_state = "hair_ponytail5"

/datum/sprite_accessory/hair/ponytail6
	name = "Ponytail 6"
	icon_state = "hair_ponytail6"

/datum/sprite_accessory/hair/ponytail7
	name = "Ponytail 7"
	icon_state = "hair_ponytail7"

/datum/sprite_accessory/hair/highponytail
	name = "Ponytail (High)"
	icon_state = "hair_highponytail"

/datum/sprite_accessory/hair/stail
	name = "Ponytail (Short)"
	icon_state = "hair_stail"

/datum/sprite_accessory/hair/longponytail
	name = "Ponytail (Long)"
	icon_state = "hair_longstraightponytail"

/datum/sprite_accessory/hair/countryponytail
	name = "Ponytail (Country)"
	icon_state = "hair_country"

/datum/sprite_accessory/hair/fringetail
	name = "Ponytail (Fringe)"
	icon_state = "hair_fringetail"

/datum/sprite_accessory/hair/sidetail
	name = "Ponytail (Side)"
	icon_state = "hair_sidetail"

/datum/sprite_accessory/hair/sidetail2
	name = "Ponytail (Side) 2"
	icon_state = "hair_sidetail2"

/datum/sprite_accessory/hair/sidetail3
	name = "Ponytail (Side) 3"
	icon_state = "hair_sidetail3"

/datum/sprite_accessory/hair/sidetail4
	name = "Ponytail (Side) 4"
	icon_state = "hair_sidetail4"

/datum/sprite_accessory/hair/spikyponytail
	name = "Ponytail (Spiky)"
	icon_state = "hair_spikyponytail"

/datum/sprite_accessory/hair/poofy
	name = "Poofy"
	icon_state = "hair_poofy"

/datum/sprite_accessory/hair/quiff
	name = "Quiff"
	icon_state = "hair_quiff"

/datum/sprite_accessory/hair/ronin
	name = "Ronin"
	icon_state = "hair_ronin"

/datum/sprite_accessory/hair/shaved
	name = "Shaved"
	icon_state = "hair_shaved"

/datum/sprite_accessory/hair/shavedpart
	name = "Shaved Part"
	icon_state = "hair_shavedpart"

/datum/sprite_accessory/hair/shortbangs
	name = "Short Bangs"
	icon_state = "hair_shortbangs"

/datum/sprite_accessory/hair/short
	name = "Short Hair"
	icon_state = "hair_a"

/datum/sprite_accessory/hair/shorthair2
	name = "Short Hair 2"
	icon_state = "hair_shorthair2"

/datum/sprite_accessory/hair/shorthair3
	name = "Short Hair 3"
	icon_state = "hair_shorthair3"

/datum/sprite_accessory/hair/shorthair4
	name = "Short Hair 4"
	icon_state = "hair_d"

/datum/sprite_accessory/hair/shorthair5
	name = "Short Hair 5"
	icon_state = "hair_e"

/datum/sprite_accessory/hair/shorthair6
	name = "Short Hair 6"
	icon_state = "hair_f"

/datum/sprite_accessory/hair/shorthair7
	name = "Short Hair 7"
	icon_state = "hair_shorthairg"

/datum/sprite_accessory/hair/shorthaireighties
	name = "Short Hair 80s"
	icon_state = "hair_80s"

/datum/sprite_accessory/hair/rosa
	name = "Short Hair Rosa"
	icon_state = "hair_rosa"

/datum/sprite_accessory/hair/shoulderlength
	name = "Shoulder-length Hair"
	icon_state = "hair_b"

/datum/sprite_accessory/hair/sidecut
	name = "Sidecut"
	icon_state = "hair_sidecut"

/datum/sprite_accessory/hair/skinhead
	name = "Skinhead"
	icon_state = "hair_skinhead"

/datum/sprite_accessory/hair/protagonist
	name = "Slightly Long Hair"
	icon_state = "hair_protagonist"

/datum/sprite_accessory/hair/spiky
	name = "Spiky"
	icon_state = "hair_spikey"

/datum/sprite_accessory/hair/spiky2
	name = "Spiky 2"
	icon_state = "hair_spiky"

/datum/sprite_accessory/hair/spiky3
	name = "Spiky 3"
	icon_state = "hair_spiky2"

/datum/sprite_accessory/hair/swept
	name = "Swept Back Hair"
	icon_state = "hair_swept"

/datum/sprite_accessory/hair/swept2
	name = "Swept Back Hair 2"
	icon_state = "hair_swept2"

/datum/sprite_accessory/hair/thinning
	name = "Thinning"
	icon_state = "hair_thinning"

/datum/sprite_accessory/hair/thinningfront
	name = "Thinning (Front)"
	icon_state = "hair_thinningfront"

/datum/sprite_accessory/hair/thinningrear
	name = "Thinning (Rear)"
	icon_state = "hair_thinningrear"

/datum/sprite_accessory/hair/topknot
	name = "Topknot"
	icon_state = "hair_topknot"

/datum/sprite_accessory/hair/tressshoulder
	name = "Tress Shoulder"
	icon_state = "hair_tressshoulder"

/datum/sprite_accessory/hair/trimmed
	name = "Trimmed"
	icon_state = "hair_trimmed"

/datum/sprite_accessory/hair/trimflat
	name = "Trim Flat"
	icon_state = "hair_trimflat"

/datum/sprite_accessory/hair/twintails
	name = "Twintails"
	icon_state = "hair_twintail"

/datum/sprite_accessory/hair/undercut
	name = "Undercut"
	icon_state = "hair_undercut"

/datum/sprite_accessory/hair/undercutleft
	name = "Undercut Left"
	icon_state = "hair_undercutleft"

/datum/sprite_accessory/hair/undercutright
	name = "Undercut Right"
	icon_state = "hair_undercutright"

/datum/sprite_accessory/hair/unkept
	name = "Unkept"
	icon_state = "hair_unkept"

/datum/sprite_accessory/hair/updo
	name = "Updo"
	icon_state = "hair_updo"

/datum/sprite_accessory/hair/longer
	name = "Very Long Hair"
	icon_state = "hair_vlong"

/datum/sprite_accessory/hair/longest
	name = "Very Long Hair 2"
	icon_state = "hair_longest"

/datum/sprite_accessory/hair/longest2
	name = "Very Long Over Eye"
	icon_state = "hair_longest2"

/datum/sprite_accessory/hair/veryshortovereye
	name = "Very Short Over Eye"
	icon_state = "hair_veryshortovereyealternate"

/datum/sprite_accessory/hair/longestalt
	name = "Very Long with Fringe"
	icon_state = "hair_vlongfringe"

/datum/sprite_accessory/hair/volaju
	name = "Volaju"
	icon_state = "hair_volaju"

/datum/sprite_accessory/hair/wisp
	name = "Wisp"
	icon_state = "hair_wisp"

/*
/////////////////////////////////////
/  =---------------------------=    /
/  == Gradient Hair Definitions ==  /
/  =---------------------------=    /
/////////////////////////////////////
*/

/datum/sprite_accessory/hair_gradient
	icon = 'icons/mob/hair_gradients.dmi'

/datum/sprite_accessory/hair_gradient/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/hair_gradient/fadeup
	name = "Fade Up"
	icon_state = "fadeup"

/datum/sprite_accessory/hair_gradient/fadedown
	name = "Fade Down"
	icon_state = "fadedown"

/datum/sprite_accessory/hair_gradient/fadevertical
	name = "Fade Vertical"
	icon_state = "fadevertical"

/datum/sprite_accessory/hair_gradient/vertical_split
	name = "Vertical Split"
	icon_state = "vsplit"

/datum/sprite_accessory/hair_gradient/_split
	name = "Horizontal Split"
	icon_state = "bottomflat"

/datum/sprite_accessory/hair_gradient/reflected
	name = "Reflected"
	icon_state = "reflected_high"

/datum/sprite_accessory/hair_gradient/reflected_inverse
	name = "Reflected Inverse"
	icon_state = "reflected_inverse_high"

/datum/sprite_accessory/hair_gradient/wavy
	name = "Wavy"
	icon_state = "wavy"

/datum/sprite_accessory/hair_gradient/long_fade_up
	name = "Long Fade Up"
	icon_state = "long_fade_up"

/datum/sprite_accessory/hair_gradient/long_fade_down
	name = "Long Fade Down"
	icon_state = "long_fade_down"

/datum/sprite_accessory/hair_gradient/long_fade_vertical
	name = "Long Fade Vertical"
	icon_state = "long_fade_vertical"

/datum/sprite_accessory/hair_gradient/short_fade_up
	name = "Short Fade Up"
	icon_state = "short_fade_up"

/datum/sprite_accessory/hair_gradient/short_fade_down
	name = "Short Fade Down"
	icon_state = "short_fade_down"

/datum/sprite_accessory/hair_gradient/wavy_spike
	name = "Spiked Wavy"
	icon_state = "wavy_spiked"

// IPC accessories.

/datum/sprite_accessory/ipc_screens
	icon = 'icons/mob/ipc_accessories.dmi'
	color_src = EYECOLOR
	emissive = TRUE

/datum/sprite_accessory/ipc_screens/blue
	name = "Blue"
	icon_state = "blue"
	color_src = 0

/datum/sprite_accessory/ipc_screens/bsod
	name = "BSOD"
	icon_state = "bsod"
	color_src = 0

/datum/sprite_accessory/ipc_screens/breakout
	name = "Breakout"
	icon_state = "breakout"

/datum/sprite_accessory/ipc_screens/blank
	name = "Null"
	icon_state = "blank"
	emissive = FALSE

/datum/sprite_accessory/ipc_screens/console
	name = "Console"
	icon_state = "console"

/datum/sprite_accessory/ipc_screens/ecgwave
	name = "ECG Wave"
	icon_state = "ecgwave"

/datum/sprite_accessory/ipc_screens/eight
	name = "Eight"
	icon_state = "eight"

/datum/sprite_accessory/ipc_screens/eyes
	name = "Eyes"
	icon_state = "eyes"

/datum/sprite_accessory/ipc_screens/eyestall
	name = "Tall Eyes"
	icon_state = "eyestall"

/datum/sprite_accessory/ipc_screens/eyesangry
	name = "Angry Eyes"
	icon_state = "eyesangry"

/datum/sprite_accessory/ipc_screens/glider
	name = "Glider"
	icon_state = "glider"

/datum/sprite_accessory/ipc_screens/goggles
	name = "Goggles"
	icon_state = "goggles"

/datum/sprite_accessory/ipc_screens/exclamation
	name = "Exclamation Point"
	icon_state = "excla"

/datum/sprite_accessory/ipc_screens/heart
	name = "Heart"
	icon_state = "heart"

/datum/sprite_accessory/ipc_screens/L
	name = "L"
	icon_state = "l"

/datum/sprite_accessory/ipc_screens/loading
	name = "Loading"
	icon_state = "loading"

/datum/sprite_accessory/ipc_screens/monoeye
	name = "Mono-eye"
	icon_state = "monoeye"

/datum/sprite_accessory/ipc_screens/nature
	name = "Nature"
	icon_state = "nature"

/datum/sprite_accessory/ipc_screens/orange
	name = "Orange"
	icon_state = "orange"

/datum/sprite_accessory/ipc_screens/pink
	name = "Pink"
	icon_state = "pink"

/datum/sprite_accessory/ipc_screens/question
	name = "Question Mark"
	icon_state = "question"

/datum/sprite_accessory/ipc_screens/ring
	name = "Ring"
	icon_state = "ring"

/datum/sprite_accessory/ipc_screens/rainbow
	name = "Rainbow"
	icon_state = "rainbow"
	color_src = 0

/datum/sprite_accessory/ipc_screens/rainbowtwo
	name = "Rainbow (Diagonal)"
	icon_state = "rainbowdiag"
	color_src = 0

/datum/sprite_accessory/ipc_screens/redtext
	name = "Red Text"
	icon_state = "redtext"
	color_src = 0

/datum/sprite_accessory/ipc_screens/rgb
	name = "RGB"
	icon_state = "rgb"

/datum/sprite_accessory/ipc_screens/scroll
	name = "Scanline"
	icon_state = "scroll"

/datum/sprite_accessory/ipc_screens/shower
	name = "Shower"
	icon_state = "shower"

/datum/sprite_accessory/ipc_screens/sinewave
	name = "Sinewave"
	icon_state = "sinewave"

/datum/sprite_accessory/ipc_screens/squarewave
	name = "Square wave"
	icon_state = "squarewave"

/datum/sprite_accessory/ipc_screens/static_screen
	name = "Static"
	icon_state = "static"

/datum/sprite_accessory/ipc_screens/stars
	name = "Stars"
	icon_state = "stars"

/datum/sprite_accessory/ipc_screens/sad
	name = "Sad"
	icon_state = "sad"

/datum/sprite_accessory/ipc_screens/smiley
	name = "Smiley"
	icon_state = "smile"

/datum/sprite_accessory/ipc_screens/tetris
	name = "Tetris"
	icon_state = "tetris"

/datum/sprite_accessory/ipc_screens/tv
	name = "Color Test"
	icon_state = "tv"

/datum/sprite_accessory/ipc_screens/textdrop
	name = "Text drop"
	icon_state = "textdrop"

/datum/sprite_accessory/ipc_screens/windowsxp
	name = "Windows XP"
	icon_state = "windowsxp"

/datum/sprite_accessory/ipc_screens/yellow
	name = "Yellow"
	icon_state = "yellow"

/datum/sprite_accessory/ipc_antennas
	icon = 'icons/mob/ipc_accessories.dmi'
	color_src = HAIR

/datum/sprite_accessory/ipc_antennas/none
	name = "None"
	icon_state = "None"

/datum/sprite_accessory/ipc_antennas/angled
	name = "Angled"
	icon_state = "antennae"

/datum/sprite_accessory/ipc_antennas/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/ipc_antennas/crowned
	name = "Crowned"
	icon_state = "crowned"

/datum/sprite_accessory/ipc_antennas/cyberhead
	name = "Cyberhead"
	icon_state = "cyberhead"

/datum/sprite_accessory/ipc_antennas/droneeyes
	name = "Drone Eyes"
	icon_state = "droneeyes"

/datum/sprite_accessory/ipc_antennas/brokenlight
	name = "Broken Light"
	icon_state = "lightb"

/datum/sprite_accessory/ipc_antennas/light
	name = "Light"
	icon_state = "light"

/datum/sprite_accessory/ipc_antennas/sidelights
	name = "Sidelights"
	icon_state = "sidelights"

/datum/sprite_accessory/ipc_antennas/tesla
	name = "Tesla"
	icon_state = "tesla"

/datum/sprite_accessory/ipc_antennas/tv
	name = "TV Antenna"
	icon_state = "tvantennae"

/datum/sprite_accessory/ipc_chassis // Used for changing limb icons, doesn't need to hold the actual icon. That's handled in ipc.dm
	icon = null
	icon_state = "who cares fuck you" // In order to pull the chassis correctly, we need AN icon_state(see line 36-39). It doesn't have to be useful, because it isn't used.
	color_src = 0

/datum/sprite_accessory/ipc_chassis/mcgreyscale
	name = "Morpheus Cyberkinetics(Greyscale)"
	limbs_id = "mcgipc"
	color_src = MUTCOLORS

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics
	name = "Bishop Cyberkinetics"
	limbs_id = "bshipc"

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics2
	name = "Bishop Cyberkinetics 2.0"
	limbs_id = "bs2ipc"

/datum/sprite_accessory/ipc_chassis/hephaestussindustries
	name = "Hephaestus Industries"
	limbs_id = "hsiipc"

/datum/sprite_accessory/ipc_chassis/hephaestussindustries2
	name = "Hephaestus Industries 2.0"
	limbs_id = "hi2ipc"

/datum/sprite_accessory/ipc_chassis/shellguardmunitions
	name = "Shellguard Munitions Standard Series"
	limbs_id = "sgmipc"

/datum/sprite_accessory/ipc_chassis/wardtakahashimanufacturing
	name = "Ward-Takahashi Manufacturing"
	limbs_id = "wtmipc"

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup
	name = "Xion Manufacturing Group"
	limbs_id = "xmgipc"

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup2
	name = "Xion Manufacturing Group 2.0"
	limbs_id = "xm2ipc"

/datum/sprite_accessory/ipc_chassis/zenghupharmaceuticals
	name = "Zeng-Hu Pharmaceuticals"
	limbs_id = "zhpipc"

/////////////////////////////
// Facial Hair Definitions //
/////////////////////////////

/datum/sprite_accessory/facial_hair
	icon = 'icons/mob/human_face.dmi'
	gender = MALE // barf (unless you're a dorf, dorfs dig chix w/ beards :P)

// please make sure they're sorted alphabetically and categorized

/datum/sprite_accessory/facial_hair/abe
	name = "Beard (Abraham Lincoln)"
	icon_state = "facial_abe"

/datum/sprite_accessory/facial_hair/brokenman
	name = "Beard (Broken Man)"
	icon_state = "facial_brokenman"

/datum/sprite_accessory/facial_hair/chinstrap
	name = "Beard (Chinstrap)"
	icon_state = "facial_chin"

/datum/sprite_accessory/facial_hair/dwarf
	name = "Beard (Dwarf)"
	icon_state = "facial_dwarf"

/datum/sprite_accessory/facial_hair/fullbeard
	name = "Beard (Full)"
	icon_state = "facial_fullbeard"

/datum/sprite_accessory/facial_hair/croppedfullbeard
	name = "Beard (Cropped Fullbeard)"
	icon_state = "facial_croppedfullbeard"

/datum/sprite_accessory/facial_hair/gt
	name = "Beard (Goatee)"
	icon_state = "facial_gt"

/datum/sprite_accessory/facial_hair/hip
	name = "Beard (Hipster)"
	icon_state = "facial_hip"

/datum/sprite_accessory/facial_hair/jensen
	name = "Beard (Jensen)"
	icon_state = "facial_jensen"

/datum/sprite_accessory/facial_hair/neckbeard
	name = "Beard (Neckbeard)"
	icon_state = "facial_neckbeard"

/datum/sprite_accessory/facial_hair/vlongbeard
	name = "Beard (Very Long)"
	icon_state = "facial_wise"

/datum/sprite_accessory/facial_hair/muttonmus
	name = "Beard (Muttonmus)"
	icon_state = "facial_muttonmus"

/datum/sprite_accessory/facial_hair/martialartist
	name = "Beard (Martial Artist)"
	icon_state = "facial_martialartist"

/datum/sprite_accessory/facial_hair/chinlessbeard
	name = "Beard (Chinless Beard)"
	icon_state = "facial_chinlessbeard"

/datum/sprite_accessory/facial_hair/moonshiner
	name = "Beard (Moonshiner)"
	icon_state = "facial_moonshiner"

/datum/sprite_accessory/facial_hair/longbeard
	name = "Beard (Long)"
	icon_state = "facial_longbeard"

/datum/sprite_accessory/facial_hair/volaju
	name = "Beard (Volaju)"
	icon_state = "facial_volaju"

/datum/sprite_accessory/facial_hair/threeoclock
	name = "Beard (Three o Clock Shadow)"
	icon_state = "facial_3oclock"

/datum/sprite_accessory/facial_hair/fiveoclock
	name = "Beard (Five o Clock Shadow)"
	icon_state = "facial_fiveoclock"

/datum/sprite_accessory/facial_hair/fiveoclockm
	name = "Beard (Five o Clock Moustache)"
	icon_state = "facial_5oclockmoustache"

/datum/sprite_accessory/facial_hair/sevenoclock
	name = "Beard (Seven o Clock Shadow)"
	icon_state = "facial_7oclock"

/datum/sprite_accessory/facial_hair/sevenoclockm
	name = "Beard (Seven o Clock Moustache)"
	icon_state = "facial_7oclockmoustache"

/datum/sprite_accessory/facial_hair/moustache
	name = "Moustache"
	icon_state = "facial_moustache"

/datum/sprite_accessory/facial_hair/pencilstache
	name = "Moustache (Pencilstache)"
	icon_state = "facial_pencilstache"

/datum/sprite_accessory/facial_hair/smallstache
	name = "Moustache (Smallstache)"
	icon_state = "facial_smallstache"

/datum/sprite_accessory/facial_hair/walrus
	name = "Moustache (Walrus)"
	icon_state = "facial_walrus"

/datum/sprite_accessory/facial_hair/fu
	name = "Moustache (Fu Manchu)"
	icon_state = "facial_fumanchu"

/datum/sprite_accessory/facial_hair/hogan
	name = "Moustache (Hulk Hogan)"
	icon_state = "facial_hogan" //-Neek

/datum/sprite_accessory/facial_hair/selleck
	name = "Moustache (Selleck)"
	icon_state = "facial_selleck"

/datum/sprite_accessory/facial_hair/chaplin
	name = "Moustache (Square)"
	icon_state = "facial_chaplin"

/datum/sprite_accessory/facial_hair/vandyke
	name = "Moustache (Van Dyke)"
	icon_state = "facial_vandyke"

/datum/sprite_accessory/facial_hair/watson
	name = "Moustache (Watson)"
	icon_state = "facial_watson"

/datum/sprite_accessory/facial_hair/elvis
	name = "Sideburns (Elvis)"
	icon_state = "facial_elvis"

/datum/sprite_accessory/facial_hair/mutton
	name = "Sideburns (Mutton Chops)"
	icon_state = "facial_mutton"

/datum/sprite_accessory/facial_hair/sideburn
	name = "Sideburns"
	icon_state = "facial_sideburn"

/datum/sprite_accessory/facial_hair/shaved
	name = "Shaved"
	icon_state = null
	gender = NEUTER

///////////////////////////
// Underwear Definitions //
///////////////////////////
/datum/sprite_accessory/underwear
	icon = 'icons/mob/clothing/sprite_accessories/underwear.dmi'
	sprite_sheets = list(
	"Vox" = 'icons/mob/clothing/species/vox/underwear.dmi',
	)

/datum/sprite_accessory/underwear/nude
	name = "Nude"
	icon_state = null
	gender = NEUTER

/datum/sprite_accessory/underwear/male_mankini
	name = "Mankini"
	icon_state = "male_mankini"
	gender = MALE

/datum/sprite_accessory/underwear/male_black
	name = "Men's Black"
	icon_state = "male_black"
	gender = MALE

/datum/sprite_accessory/underwear/male_blackalt
	name = "Men's Black Boxer"
	icon_state = "male_blackalt"
	gender = MALE

/datum/sprite_accessory/underwear/male_blue
	name = "Men's Blue"
	icon_state = "male_blue"
	gender = MALE

/datum/sprite_accessory/underwear/male_green
	name = "Men's Green"
	icon_state = "male_green"
	gender = MALE

/datum/sprite_accessory/underwear/male_grey
	name = "Men's Grey"
	icon_state = "male_grey"
	gender = MALE

/datum/sprite_accessory/underwear/male_greyalt
	name = "Men's Grey Boxer"
	icon_state = "male_greyalt"
	gender = MALE

/datum/sprite_accessory/underwear/male_hearts
	name = "Men's Hearts Boxer"
	icon_state = "male_hearts"
	gender = MALE

/datum/sprite_accessory/underwear/male_kinky
	name = "Men's Kinky"
	icon_state = "male_kinky"
	gender = MALE

/datum/sprite_accessory/underwear/male_red
	name = "Men's Red"
	icon_state = "male_red"
	gender = MALE

/datum/sprite_accessory/underwear/male_stripe
	name = "Men's Striped Boxer"
	icon_state = "male_stripe"
	gender = MALE

/datum/sprite_accessory/underwear/male_commie
	name = "Men's Striped Commie Boxer"
	icon_state = "male_commie"
	gender = MALE

/datum/sprite_accessory/underwear/male_usastripe
	name = "Men's Striped Freedom Boxer"
	icon_state = "male_assblastusa"
	gender = MALE

/datum/sprite_accessory/underwear/male_uk
	name = "Men's Striped UK Boxer"
	icon_state = "male_uk"
	gender = MALE

/datum/sprite_accessory/underwear/male_white
	name = "Men's White"
	icon_state = "male_white"
	gender = MALE

/datum/sprite_accessory/underwear/female_babydoll
	name = "Babydoll"
	icon_state = "female_babydoll"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_babyblue
	name = "Ladies' Baby-Blue"
	icon_state = "female_babyblue"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_black
	name = "Ladies' Black"
	icon_state = "female_black"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_black_neko
	name = "Ladies' Black Neko"
	icon_state = "female_neko_black"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_blackalt
	name = "Ladies' Black Sport"
	icon_state = "female_blackalt"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_blue
	name = "Ladies' Blue"
	icon_state = "female_blue"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_commie
	name = "Ladies' Commie"
	icon_state = "female_commie"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_usastripe
	name = "Ladies' Freedom"
	icon_state = "female_assblastusa"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_green
	name = "Ladies' Green"
	icon_state = "female_green"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_kinky
	name = "Ladies' Kinky"
	icon_state = "female_kinky"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_pink
	name = "Ladies' Pink"
	icon_state = "female_pink"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_red
	name = "Ladies' Red"
	icon_state = "female_red"
	gender = FEMALE

/datum/sprite_accessory/underwear/swimsuit
	name = "Ladies' Swimsuit (Black)"
	icon_state = "swim_black"
	gender = FEMALE

/datum/sprite_accessory/underwear/swimsuit_blue
	name = "Ladies' Swimsuit (Blue)"
	icon_state = "swim_blue"
	gender = FEMALE

/datum/sprite_accessory/underwear/swimsuit_green
	name = "Ladies' Swimsuit (Green)"
	icon_state = "swim_green"
	gender = FEMALE

/datum/sprite_accessory/underwear/swimsuit_purple
	name = "Ladies' Swimsuit (Purple)"
	icon_state = "swim_purple"
	gender = FEMALE

/datum/sprite_accessory/underwear/swimsuit_red
	name = "Ladies' Swimsuit (Red)"
	icon_state = "swim_red"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_thong
	name = "Ladies' Thong"
	icon_state = "female_thong"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_uk
	name = "Ladies' UK"
	icon_state = "female_uk"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_white
	name = "Ladies' White"
	icon_state = "female_white"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_white_neko
	name = "Ladies' White Neko"
	icon_state = "female_neko_white"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_whitealt
	name = "Ladies' White Sport"
	icon_state = "female_whitealt"
	gender = FEMALE

/datum/sprite_accessory/underwear/female_yellow
	name = "Ladies' Yellow"
	icon_state = "female_yellow"
	gender = FEMALE

////////////////////////////
// Undershirt Definitions //
////////////////////////////

/datum/sprite_accessory/undershirt
	icon = 'icons/mob/clothing/sprite_accessories/undershirt.dmi'
	sprite_sheets = list(
	"Vox" = 'icons/mob/clothing/species/vox/undershirt.dmi',
	)

/datum/sprite_accessory/undershirt/nude
	name = "Nude"
	icon_state = null
	gender = NEUTER

// please make sure they're sorted alphabetically and categorized

/datum/sprite_accessory/undershirt/bluejersey
	name = "Jersey (Blue)"
	icon_state = "shirt_bluejersey"
	gender = NEUTER

/datum/sprite_accessory/undershirt/redjersey
	name = "Jersey (Red)"
	icon_state = "shirt_redjersey"
	gender = NEUTER

/datum/sprite_accessory/undershirt/bluepolo
	name = "Polo Shirt (Blue)"
	icon_state = "bluepolo"
	gender = NEUTER

/datum/sprite_accessory/undershirt/grayyellowpolo
	name = "Polo Shirt (Gray-Yellow)"
	icon_state = "grayyellowpolo"
	gender = NEUTER

/datum/sprite_accessory/undershirt/redpolo
	name = "Polo Shirt (Red)"
	icon_state = "redpolo"
	gender = NEUTER

/datum/sprite_accessory/undershirt/whitepolo
	name = "Polo Shirt (White)"
	icon_state = "whitepolo"
	gender = NEUTER

/datum/sprite_accessory/undershirt/alienshirt
	name = "Shirt (Alien)"
	icon_state = "shirt_alien"
	gender = NEUTER

/datum/sprite_accessory/undershirt/mondmondjaja
	name = "Shirt (Band)"
	icon_state = "band"
	gender = NEUTER

/datum/sprite_accessory/undershirt/shirt_black
	name = "Shirt (Black)"
	icon_state = "shirt_black"
	gender = NEUTER

/datum/sprite_accessory/undershirt/blueshirt
	name = "Shirt (Blue)"
	icon_state = "shirt_blue"
	gender = NEUTER

/datum/sprite_accessory/undershirt/clownshirt
	name = "Shirt (Clown)"
	icon_state = "shirt_clown"
	gender = NEUTER

/datum/sprite_accessory/undershirt/commie
	name = "Shirt (Commie)"
	icon_state = "shirt_commie"
	gender = NEUTER

/datum/sprite_accessory/undershirt/greenshirt
	name = "Shirt (Green)"
	icon_state = "shirt_green"
	gender = NEUTER

/datum/sprite_accessory/undershirt/shirt_grey
	name = "Shirt (Grey)"
	icon_state = "shirt_grey"
	gender = NEUTER

/datum/sprite_accessory/undershirt/ian
	name = "Shirt (Ian)"
	icon_state = "ian"
	gender = NEUTER

/datum/sprite_accessory/undershirt/ilovent
	name = "Shirt (I Love NT)"
	icon_state = "ilovent"
	gender = NEUTER

/datum/sprite_accessory/undershirt/lover
	name = "Shirt (Lover)"
	icon_state = "lover"
	gender = NEUTER

/datum/sprite_accessory/undershirt/matroska
	name = "Shirt (Matroska)"
	icon_state = "matroska"
	gender = NEUTER

/datum/sprite_accessory/undershirt/meat
	name = "Shirt (Meat)"
	icon_state = "shirt_meat"
	gender = NEUTER

/datum/sprite_accessory/undershirt/nano
	name = "Shirt (Nanotrasen)"
	icon_state = "shirt_nano"
	gender = NEUTER

/datum/sprite_accessory/undershirt/peace
	name = "Shirt (Peace)"
	icon_state = "peace"
	gender = NEUTER

/datum/sprite_accessory/undershirt/pacman
	name = "Shirt (Pogoman)"
	icon_state = "pogoman"
	gender = NEUTER

/datum/sprite_accessory/undershirt/question
	name = "Shirt (Question)"
	icon_state = "shirt_question"
	gender = NEUTER

/datum/sprite_accessory/undershirt/redshirt
	name = "Shirt (Red)"
	icon_state = "shirt_red"
	gender = NEUTER

/datum/sprite_accessory/undershirt/skull
	name = "Shirt (Skull)"
	icon_state = "shirt_skull"
	gender = NEUTER

/datum/sprite_accessory/undershirt/ss13
	name = "Shirt (SS13)"
	icon_state = "shirt_ss13"
	gender = NEUTER

/datum/sprite_accessory/undershirt/stripe
	name = "Shirt (Striped)"
	icon_state = "shirt_stripes"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tiedye
	name = "Shirt (Tie-dye)"
	icon_state = "shirt_tiedye"
	gender = NEUTER

/datum/sprite_accessory/undershirt/uk
	name = "Shirt (UK)"
	icon_state = "uk"
	gender = NEUTER

/datum/sprite_accessory/undershirt/usa
	name = "Shirt (USA)"
	icon_state = "shirt_assblastusa"
	gender = NEUTER

/datum/sprite_accessory/undershirt/shirt_white
	name = "Shirt (White)"
	icon_state = "shirt_white"
	gender = NEUTER

/datum/sprite_accessory/undershirt/blackshortsleeve
	name = "Short-sleeved Shirt (Black)"
	icon_state = "blackshortsleeve"
	gender = NEUTER

/datum/sprite_accessory/undershirt/blueshortsleeve
	name = "Short-sleeved Shirt (Blue)"
	icon_state = "blueshortsleeve"
	gender = NEUTER

/datum/sprite_accessory/undershirt/greenshortsleeve
	name = "Short-sleeved Shirt (Green)"
	icon_state = "greenshortsleeve"
	gender = NEUTER

/datum/sprite_accessory/undershirt/purpleshortsleeve
	name = "Short-sleeved Shirt (Purple)"
	icon_state = "purpleshortsleeve"
	gender = NEUTER

/datum/sprite_accessory/undershirt/whiteshortsleeve
	name = "Short-sleeved Shirt (White)"
	icon_state = "whiteshortsleeve"
	gender = NEUTER

/datum/sprite_accessory/undershirt/sports_bra
	name = "Sports Bra"
	icon_state = "sports_bra"
	gender = NEUTER

/datum/sprite_accessory/undershirt/sports_bra2
	name = "Sports Bra (Alt)"
	icon_state = "sports_bra_alt"
	gender = NEUTER

/datum/sprite_accessory/undershirt/blueshirtsport
	name = "Sports Shirt (Blue)"
	icon_state = "blueshirtsport"
	gender = NEUTER

/datum/sprite_accessory/undershirt/greenshirtsport
	name = "Sports Shirt (Green)"
	icon_state = "greenshirtsport"
	gender = NEUTER

/datum/sprite_accessory/undershirt/redshirtsport
	name = "Sports Shirt (Red)"
	icon_state = "redshirtsport"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_black
	name = "Tank Top (Black)"
	icon_state = "tank_black"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tankfire
	name = "Tank Top (Fire)"
	icon_state = "tank_fire"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_grey
	name = "Tank Top (Grey)"
	icon_state = "tank_grey"
	gender = NEUTER

/datum/sprite_accessory/undershirt/female_midriff
	name = "Tank Top (Midriff)"
	icon_state = "tank_midriff"
	gender = FEMALE

/datum/sprite_accessory/undershirt/tank_red
	name = "Tank Top (Red)"
	icon_state = "tank_red"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tankstripe
	name = "Tank Top (Striped)"
	icon_state = "tank_stripes"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_white
	name = "Tank Top (White)"
	icon_state = "tank_white"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_rainbow
	name = "Tank Top (Rainbow)"
	icon_state = "tank_rainbow"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_ace
	name = "Tank Top (Asexual)"
	icon_state = "tank_ace"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_bi
	name = "Tank Top (Bi)"
	icon_state = "tank_bi"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_les
	name = "Tank Top (Lesbian)"
	icon_state = "tank_les"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_enby
	name = "Tank Top (Nonbinary)"
	icon_state = "tank_enby"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tank_trans
	name = "Tank Top (Trans)"
	icon_state = "tank_trans"
	gender = NEUTER

/datum/sprite_accessory/undershirt/redtop
	name = "Top (Red)"
	icon_state = "redtop"
	gender = FEMALE

/datum/sprite_accessory/undershirt/whitetop
	name = "Top (White)"
	icon_state = "whitetop"
	gender = FEMALE

/datum/sprite_accessory/undershirt/tshirt_blue
	name = "T-Shirt (Blue)"
	icon_state = "blueshirt"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tshirt_green
	name = "T-Shirt (Green)"
	icon_state = "greenshirt"
	gender = NEUTER

/datum/sprite_accessory/undershirt/tshirt_red
	name = "T-Shirt (Red)"
	icon_state = "redshirt"
	gender = NEUTER

/datum/sprite_accessory/undershirt/yellowshirt
	name = "T-Shirt (Yellow)"
	icon_state = "yellowshirt"
	gender = NEUTER

///////////////////////
// Socks Definitions //
///////////////////////

/datum/sprite_accessory/socks
	icon = 'icons/mob/clothing/sprite_accessories/socks.dmi'
	sprite_sheets = list(
	"Vox" = 'icons/mob/clothing/species/vox/socks.dmi',
	)

/datum/sprite_accessory/socks/nude
	name = "Nude"
	icon_state = null

// please make sure they're sorted alphabetically and categorized

/datum/sprite_accessory/socks/bee_knee
	name = "Knee-high (Bee)"
	icon_state = "bee_knee"

/datum/sprite_accessory/socks/black_knee
	name = "Knee-high (Black)"
	icon_state = "black_knee"

/datum/sprite_accessory/socks/commie_knee
	name = "Knee-high (Commie)"
	icon_state = "commie_knee"

/datum/sprite_accessory/socks/usa_knee
	name = "Knee-high (Freedom)"
	icon_state = "assblastusa_knee"

/datum/sprite_accessory/socks/rainbow_knee
	name = "Knee-high (Rainbow)"
	icon_state = "rainbow_knee"

/datum/sprite_accessory/socks/ace_knee
	name = "Knee-high (Asexual)"
	icon_state = "ace_knee" // can be used to show that you follow rule 0.2

/datum/sprite_accessory/socks/bi_knee
	name = "Knee-high (Bi)"
	icon_state = "bi_knee"

/datum/sprite_accessory/socks/les_knee
	name = "Knee-high (Lesbian)"
	icon_state = "les_knee"

/datum/sprite_accessory/socks/enby_knee
	name = "Knee-high (Nonbinary)"
	icon_state = "enby_knee"

/datum/sprite_accessory/socks/trans_knee
	name = "Knee-high (Trans)"
	icon_state = "trans_knee"

/datum/sprite_accessory/socks/striped_knee
	name = "Knee-high (Striped)"
	icon_state = "striped_knee"

/datum/sprite_accessory/socks/thin_knee
	name = "Knee-high (Thin)"
	icon_state = "thin_knee"

/datum/sprite_accessory/socks/uk_knee
	name = "Knee-High (UK)"
	icon_state = "uk_knee"

/datum/sprite_accessory/socks/white_knee
	name = "Knee-high (White)"
	icon_state = "white_knee"

/datum/sprite_accessory/socks/black_norm
	name = "Normal (Black)"
	icon_state = "black_norm"

/datum/sprite_accessory/socks/white_norm
	name = "Normal (White)"
	icon_state = "white_norm"

/datum/sprite_accessory/socks/pantyhose
	name = "Pantyhose"
	icon_state = "pantyhose"

/datum/sprite_accessory/socks/black_short
	name = "Short (Black)"
	icon_state = "black_short"

/datum/sprite_accessory/socks/white_short
	name = "Short (White)"
	icon_state = "white_short"

/datum/sprite_accessory/socks/stockings_blue
	name = "Stockings (Blue)"
	icon_state = "stockings_blue"

/datum/sprite_accessory/socks/stockings_cyan
	name = "Stockings (Cyan)"
	icon_state = "stockings_cyan"

/datum/sprite_accessory/socks/stockings_dpink
	name = "Stockings (Dark Pink)"
	icon_state = "stockings_dpink"

/datum/sprite_accessory/socks/stockings_green
	name = "Stockings (Green)"
	icon_state = "stockings_green"

/datum/sprite_accessory/socks/stockings_orange
	name = "Stockings (Orange)"
	icon_state = "stockings_orange"

/datum/sprite_accessory/socks/stockings_programmer
	name = "Stockings (Programmer)"
	icon_state = "stockings_lpink"

/datum/sprite_accessory/socks/stockings_purple
	name = "Stockings (Purple)"
	icon_state = "stockings_purple"

/datum/sprite_accessory/socks/stockings_yellow
	name = "Stockings (Yellow)"
	icon_state = "stockings_yellow"

/datum/sprite_accessory/socks/bee_thigh
	name = "Thigh-high (Bee)"
	icon_state = "bee_thigh"

/datum/sprite_accessory/socks/black_thigh
	name = "Thigh-high (Black)"
	icon_state = "black_thigh"

/datum/sprite_accessory/socks/commie_thigh
	name = "Thigh-high (Commie)"
	icon_state = "commie_thigh"

/datum/sprite_accessory/socks/usa_thigh
	name = "Thigh-high (Freedom)"
	icon_state = "assblastusa_thigh"

/datum/sprite_accessory/socks/rainbow_thigh
	name = "Thigh-high (Rainbow)"
	icon_state = "rainbow_thigh"

/datum/sprite_accessory/socks/ace_thigh
	name = "Thigh-high (Asexual)"
	icon_state = "ace_thigh"

/datum/sprite_accessory/socks/bi_thigh
	name = "Thigh-high (Bi)"
	icon_state = "bi_thigh" //bi thigh highs? we gotta study this

/datum/sprite_accessory/socks/les_thigh
	name = "Thigh-high (Lesbian)"
	icon_state = "les_thigh"

/datum/sprite_accessory/socks/enby_thigh
	name = "Thigh-high (Nonbinary)"
	icon_state = "enby_thigh"

/datum/sprite_accessory/socks/trans_thigh
	name = "Thigh-high (Trans)"
	icon_state = "trans_thigh"

/datum/sprite_accessory/socks/striped_thigh
	name = "Thigh-high (Striped)"
	icon_state = "striped_thigh"

/datum/sprite_accessory/socks/thin_thigh
	name = "Thigh-high (Thin)"
	icon_state = "thin_thigh"

/datum/sprite_accessory/socks/uk_thigh
	name = "Thigh-high (UK)"
	icon_state = "uk_thigh"

/datum/sprite_accessory/socks/white_thigh
	name = "Thigh-high (White)"
	icon_state = "white_thigh"

//////////.//////////////////
// MutantParts Definitions //
/////////////////////////////

/datum/sprite_accessory/body_markings
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/body_markings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/body_markings/dtiger
	name = "Dark Tiger Body"
	icon_state = "dtiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/ltiger
	name = "Light Tiger Body"
	icon_state = "ltiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/lbelly
	name = "Light Belly"
	icon_state = "lbelly"
	gender_specific = 1

/datum/sprite_accessory/tails
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/tails_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/tails/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails_animated/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails_animated/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/tails_animated/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/tails/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/tails_animated/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/tails/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/tails_animated/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/snouts
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/snouts/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/snouts/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/snouts/sharplight
	name = "Sharp + Light"
	icon_state = "sharplight"

/datum/sprite_accessory/snouts/roundlight
	name = "Round + Light"
	icon_state = "roundlight"

/datum/sprite_accessory/horns
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/horns/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/horns/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/horns/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/horns/curled
	name = "Curled"
	icon_state = "curled"

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/angler
	name = "Angler"
	icon_state = "doodlybopper" //TRUE NAME

/datum/sprite_accessory/horns/tiny
	name = "Tiny"
	icon_state = "tiny"

/datum/sprite_accessory/horns/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/horns/knight
	name = "Knight"
	icon_state = "knight"

/datum/sprite_accessory/horns/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/ears
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/ears/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/ears/cat
	name = "Cat"
	icon_state = "cat"
	hasinner = 1
	color_src = HAIR

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/wings_open
	icon = 'icons/mob/wings.dmi'

/datum/sprite_accessory/wings
	icon = 'icons/mob/wings.dmi'

/datum/sprite_accessory/wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE

/datum/sprite_accessory/wings_open/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34

/datum/sprite_accessory/wings/plant
	name = "Plant"
	icon_state = "plant"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = HAIR

/datum/sprite_accessory/wings_open/plant
	name = "Plant"
	icon_state = "plant"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = HAIR

/datum/sprite_accessory/wings/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/wings/skeleton
	name = "Skeleton"
	icon_state = "skele"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/skeleton
	name = "Skeleton"
	icon_state = "skele"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/wings/robotic
	name = "Robotic"
	icon_state = "robotic"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/robotic
	name = "Robotic"
	icon_state = "robotic"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/wings/plant
	name = "Plant"
	icon_state = "plant"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = HAIR

/datum/sprite_accessory/wings_open/plant
	name = "Plant"
	icon_state = "plant"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	color_src = HAIR

/datum/sprite_accessory/wings/plantdetails
	name = "Plantdetails"
	icon_state = "plantdetails"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/plantdetails
	name = "Plantdetails"
	icon_state = "plantdetails"
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/wings/ethereal
	name = "Ethereal"
	icon_state = "ethereal"
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE
	emissive = TRUE

/datum/sprite_accessory/wings_open/ethereal
	name = "Ethereal"
	icon_state = "ethereal"
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	emissive = TRUE

/datum/sprite_accessory/wings/etherealdetails
	name = "Etherealdetails"
	icon_state = "etherealdetails"
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE
	color_src = null
	emissive = TRUE

/datum/sprite_accessory/wings_open/etherealdetails
	name = "Etherealdetails"
	icon_state = "etherealdetails"
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	color_src = null
	emissive = TRUE

/datum/sprite_accessory/wings/elytra
	name = "Elytra"
	icon_state = "elytra"
	dimension_x = 32
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = EYECOLOR
	emissive = TRUE

/datum/sprite_accessory/wings_open/elytra
	name = "Elytra"
	icon_state = "elytra"
	dimension_x = 64
	center = TRUE
	dimension_y = 32
	color_src = EYECOLOR
	emissive = TRUE

/datum/sprite_accessory/frills
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/frills/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/frills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/frills/full
	name = "Full"
	icon_state = "full"

/datum/sprite_accessory/frills/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/frills/split
	name = "Split"
	icon_state = "split"

/datum/sprite_accessory/spines
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/spines_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/spines/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines_animated/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines_animated/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/spines_animated/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/spines/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines_animated/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines_animated/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/spines_animated/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/legs 	//legs are a special case, they aren't actually sprite_accessories but are updated with them.
	icon = null					//These datums exist for selecting legs on preference, and little else

/datum/sprite_accessory/legs/none
	name = "Normal Legs"

/datum/sprite_accessory/legs/digitigrade_lizard
	name = "Digitigrade Legs"

/datum/sprite_accessory/caps
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = HAIR

/datum/sprite_accessory/caps/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/moth_wings
	icon = 'yogstation/icons/mob/wings.dmi' //yogs moth sprite fix
	color_src = null
	
/datum/sprite_accessory/moth_wingsopen
	icon = 'icons/mob/moth_wingsopen.dmi'
	color_src = null
	dimension_x = 76
	center = TRUE

/datum/sprite_accessory/moth_wings/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/moth_wingsopen/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/moth_wings/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/moth_wingsopen/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/moth_wings/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/moth_wingsopen/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/moth_wings/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/moth_wingsopen/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/moth_wings/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/moth_wingsopen/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/moth_wings/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/moth_wingsopen/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/moth_wings/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/moth_wingsopen/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/moth_wings/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/moth_wingsopen/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/moth_wings/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/moth_wingsopen/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/moth_wings/punished
	name = "Burnt Off"
	icon_state = "punished"
	locked = TRUE

/datum/sprite_accessory/moth_wings/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/moth_wingsopen/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/moth_wings/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/moth_wingsopen/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/moth_wings/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/moth_wingsopen/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/moth_wings/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/moth_wingsopen/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/moth_wings/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/moth_wingsopen/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/moth_wings/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/moth_wingsopen/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/tails/polysmorph/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/tails/polysmorph/polys
	name = "Polys"
	icon_state = "polys"
	color_src = MUTCOLORS

/datum/sprite_accessory/teeth
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = null

/datum/sprite_accessory/teeth/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/teeth/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/teeth/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/dome
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/dome/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/dome/queen
	name = "Queen"
	icon_state = "queen"

/datum/sprite_accessory/dome/praetorian
	name = "Praetorian"
	icon_state = "praetorian"

/datum/sprite_accessory/dome/drone
	name = "Drone"
	icon_state = "drone"

/datum/sprite_accessory/dome/hunter
	name = "Hunter"
	icon_state = "hunter"

/datum/sprite_accessory/dorsal_tubes
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/dorsal_tubes/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/dorsal_tubes/dtsingle
	name = "Single"
	icon_state = "dtsingle"

/datum/sprite_accessory/dorsal_tubes/dtdouble
	name = "Double"
	icon_state = "dtdouble"

/datum/sprite_accessory/dorsal_tubes/dtsplit
	name = "Split"
	icon_state = "dtsplit"

/datum/sprite_accessory/dorsal_tubes/dtdown
	name = "Down"
	icon_state = "dtdown"

//ETHEREAL FACE MARKINGS
/datum/sprite_accessory/ethereal_mark
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = EYECOLOR
	emissive = TRUE

/datum/sprite_accessory/ethereal_mark/cheese
	name = "Cheese"
	icon_state = "cheese"

/datum/sprite_accessory/ethereal_mark/druid
	name = "Druid"
	icon_state = "druid"

/datum/sprite_accessory/ethereal_mark/eyes
	name = "Eyes"
	icon_state = "eyes"

/datum/sprite_accessory/ethereal_mark/full
	name = "Full"
	icon_state = "full"

/datum/sprite_accessory/ethereal_mark/diamond
	name = "Diamond"
	icon_state = "diamond"

/datum/sprite_accessory/ethereal_mark/heart
	name = "Heart"
	icon_state = "heart"

/datum/sprite_accessory/ethereal_mark/mc
	name = "M.C."
	icon_state = "mc"

/datum/sprite_accessory/ethereal_mark/nova
	name = "Nova"
	icon_state = "nova"

/datum/sprite_accessory/ethereal_mark/omega
	name = "Omega"
	icon_state = "omega"

/datum/sprite_accessory/ethereal_mark/onion
	name = "Onion"
	icon_state = "onion"

/datum/sprite_accessory/ethereal_mark/plus
	name = "Plus"
	icon_state = "plus"

/datum/sprite_accessory/ethereal_mark/shard
	name = "Shard"
	icon_state = "shard"

/datum/sprite_accessory/ethereal_mark/stars
	name = "Stars"
	icon_state = "stars"

/datum/sprite_accessory/ethereal_mark/triangle
	name = "Triangle"
	icon_state = "triangle"

/datum/sprite_accessory/ethereal_mark/x
	name = "X"
	icon_state = "x"

//Preternis body weathering
/datum/sprite_accessory/preternis_weathering
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = null

/datum/sprite_accessory/preternis_weathering/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/preternis_weathering/damaged
	name = "Damaged"
	icon_state = "damaged"

/datum/sprite_accessory/preternis_weathering/rusted
	name = "Rusted"
	icon_state = "rusted"

/datum/sprite_accessory/preternis_weathering/repaired
	name = "Repaired"
	icon_state = "repaired"

/datum/sprite_accessory/preternis_weathering/fullchasis
	name = "Full chassis"
	icon_state = "fullchassis"

/datum/sprite_accessory/preternis_weathering/fullbody
	name = "Upper body"
	icon_state = "fullbody"

/datum/sprite_accessory/preternis_weathering/halfbody
	name = "Upper body (minor)"
	icon_state = "halfbody"

/datum/sprite_accessory/preternis_weathering/rightarm
	name = "Right arm"
	icon_state = "rightarm"

/datum/sprite_accessory/preternis_weathering/leftarm
	name = "Left arm"
	icon_state = "leftarm"

/datum/sprite_accessory/preternis_weathering/fullarm
	name = "Both arms"
	icon_state = "fullarm"

/datum/sprite_accessory/preternis_weathering/halfarm
	name = "Both arms (minor)"
	icon_state = "halfarm"

/datum/sprite_accessory/preternis_weathering/waist
	name = "Waist"
	icon_state = "waist"

//Preternis body weathering
/datum/sprite_accessory/preternis_antenna
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/preternis_antenna/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/preternis_antenna/dracula
	name = "Dracula"
	icon_state = "dracula"

/datum/sprite_accessory/preternis_antenna/ghost
	name = "Ghost"
	icon_state = "ghost"

/datum/sprite_accessory/preternis_antenna/army
	name = "Army"
	icon_state = "army"

/datum/sprite_accessory/preternis_antenna/praetor
	name = "Praetor"
	icon_state = "praetor"

/datum/sprite_accessory/preternis_antenna/field
	name = "Field"
	icon_state = "field"

/datum/sprite_accessory/preternis_antenna/driver
	name = "Driver"
	icon_state = "driver"

//Preternis eye
/datum/sprite_accessory/preternis_eye
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = EYECOLOR
	emissive = TRUE

/datum/sprite_accessory/preternis_eye/one
	name = "Standard"
	icon_state = "1"

/datum/sprite_accessory/preternis_eye/two
	name = "Focused"
	icon_state = "2"
	
/datum/sprite_accessory/preternis_eye/three
	name = "Fanned"
	icon_state = "3"

/datum/sprite_accessory/preternis_eye/four
	name = "Horizontal"
	icon_state = "4"

/datum/sprite_accessory/preternis_eye/six
	name = "Vertical"
	icon_state = "6"

/datum/sprite_accessory/preternis_eye/five
	name = "Chambered"
	icon_state = "5"

/datum/sprite_accessory/preternis_eye/seven
	name = "Compound"
	icon_state = "7"

/datum/sprite_accessory/preternis_eye/visionary
	name = "Visionary"
	icon_state = "8"

//preternis core
/datum/sprite_accessory/preternis_core
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = EYECOLOR
	emissive = TRUE

/datum/sprite_accessory/preternis_core/core
	name = "Core"
	icon_state = "core"

//Phytosian hair
/datum/sprite_accessory/pod_hair
	icon = 'icons/mob/pod_hair.dmi'
	color_src = HAIR

/datum/sprite_accessory/pod_hair/bud
	name = "Bud"
	icon_state = "pod_hair_bud"

/datum/sprite_accessory/pod_hair/cabbage
	name = "Cabbage"
	icon_state = "pod_hair_cabbage"

/datum/sprite_accessory/pod_hair/fig
	name = "Fig"
	icon_state = "pod_hair_fig"

/datum/sprite_accessory/pod_hair/hibiscus
	name = "Hibiscus"
	icon_state = "pod_hair_hibiscus"

/datum/sprite_accessory/pod_hair/ivy
	name = "Ivy"
	icon_state = "pod_hair_ivy"

/datum/sprite_accessory/pod_hair/orchid
	name = "Orchid"
	icon_state = "pod_hair_orchid"

/datum/sprite_accessory/pod_hair/prayer
	name = "Prayer"
	icon_state = "pod_hair_prayer"

/datum/sprite_accessory/pod_hair/rose
	name = "Rose"
	icon_state = "pod_hair_rose"

/datum/sprite_accessory/pod_hair/shrub
	name = "Shrub"
	icon_state = "pod_hair_shrub"

/datum/sprite_accessory/pod_hair/spinach
	name = "Spinach"
	icon_state = "pod_hair_spinach"

/datum/sprite_accessory/pod_hair/vine
	name = "Vine"
	icon_state = "pod_hair_vine"

//Phytosian hair flower
/datum/sprite_accessory/pod_flower
	icon = 'icons/mob/pod_hair.dmi'
	color_src = FACEHAIR

/datum/sprite_accessory/pod_flower/bud
	name = "Bud"
	icon_state = "pod_flower_bud"

/datum/sprite_accessory/pod_flower/cabbage
	name = "Cabbage"
	icon_state = "pod_flower_cabbage"

/datum/sprite_accessory/pod_flower/fig
	name = "Fig"
	icon_state = "pod_flower_fig"

/datum/sprite_accessory/pod_flower/hibiscus
	name = "Hibiscus"
	icon_state = "pod_flower_hibiscus"

/datum/sprite_accessory/pod_flower/ivy
	name = "Ivy"
	icon_state = "pod_flower_ivy"

/datum/sprite_accessory/pod_flower/orchid
	name = "Orchid"
	icon_state = "pod_flower_orchid"

/datum/sprite_accessory/pod_flower/prayer
	name = "Prayer"
	icon_state = "pod_flower_prayer"

/datum/sprite_accessory/pod_flower/rose
	name = "Rose"
	icon_state = "pod_flower_rose"

/datum/sprite_accessory/pod_flower/shrub
	name = "Shrub"
	icon_state = "pod_flower_shrub"

/datum/sprite_accessory/pod_flower/spinach
	name = "Spinach"
	icon_state = "pod_flower_spinach"

/datum/sprite_accessory/pod_flower/vine
	name = "Vine"
	icon_state = "pod_flower_vine"

// Vox Accessories

/datum/sprite_accessory/vox_quills
	icon = 'icons/mob/species/vox/quills.dmi'
	color_src = HAIR
	color_blend_mode = "add"

/datum/sprite_accessory/vox_quills/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/vox_quills/crested
	name = "Crested"
	icon_state = "crested"

/datum/sprite_accessory/vox_quills/emperor
	name = "Emperor"
	icon_state = "emperor"

/datum/sprite_accessory/vox_quills/keel
	name = "Keel"
	icon_state = "keel"

/datum/sprite_accessory/vox_quills/keet
	name = "Keet"
	icon_state = "keet"

/datum/sprite_accessory/vox_quills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/vox_quills/tiel
	name = "Tiel"
	icon_state = "tiel"

/datum/sprite_accessory/vox_quills/kingly
	name = "Kingly"
	icon_state = "kingly"

/datum/sprite_accessory/vox_quills/afro
	name = "Fluffy"
	icon_state = "afro"

/datum/sprite_accessory/vox_quills/yasuhiro
	name = "Long"
	icon_state = "yasuhiro"

/datum/sprite_accessory/vox_quills/razor
	name = "Razorback"
	icon_state = "razor"

/datum/sprite_accessory/vox_quills/razor_clipped
	name = "Clipped Razorback"
	icon_state = "razor_clipped"

/datum/sprite_accessory/vox_quills/long_braid
	name = "Long Braided"
	icon_state = "long_braid"

/datum/sprite_accessory/vox_quills/short_braid
	name = "Short Braided"
	icon_state = "short_braid"

/datum/sprite_accessory/vox_quills/mowhawk
	name = "Mohawk"
	icon_state = "mohawk"

/datum/sprite_accessory/vox_quills/hawk
	name = "Hawk"
	icon_state = "hawk"

/datum/sprite_accessory/vox_quills/horns
	name = "Horns"
	icon_state = "horns"

/datum/sprite_accessory/vox_quills/mange
	name = "Mange"
	icon_state = "mange"

/datum/sprite_accessory/vox_quills/ponytail
	name = "Ponytail"
	icon_state = "ponytail"

/datum/sprite_accessory/vox_quills/rows
	name = "Rows"
	icon_state = "rows"

/datum/sprite_accessory/vox_quills/surf
	name = "Surf"
	icon_state = "surf"

/datum/sprite_accessory/vox_quills/flowing
	name = "Flowing"
	icon_state = "flowing"

/datum/sprite_accessory/vox_quills/nights
	name = "Nights"
	icon_state = "nights"

/datum/sprite_accessory/vox_quills/cropped
	name = "Cropped"
	icon_state = "cropped"

/datum/sprite_accessory/vox_facial_quills
	icon = 'icons/mob/species/vox/facial_quills.dmi'
	color_src = FACEHAIR
	color_blend_mode = "add"

/datum/sprite_accessory/vox_facial_quills/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/vox_facial_quills/colonel
	name = "Colonel"
	icon_state = "colonel"

/datum/sprite_accessory/vox_facial_quills/fu
	name = "Fu"
	icon_state = "fu"

/datum/sprite_accessory/vox_facial_quills/neck
	name = "Neck"
	icon_state = "neck"

/datum/sprite_accessory/vox_facial_quills/beard
	name = "Beard"
	icon_state = "beard"

/datum/sprite_accessory/vox_facial_quills/ruff
	name = "Ruff"
	icon_state = "ruff"

/datum/sprite_accessory/vox_tails
	icon = 'icons/mob/species/vox/tails.dmi'
	color_src = NONE

/datum/sprite_accessory/vox_tails/green
	name = "green"
	icon_state = "green"

/datum/sprite_accessory/vox_tails/crimson
	name = "crimson"
	icon_state = "crimson"

/datum/sprite_accessory/tails_animated/vox
	icon = 'icons/mob/species/vox/tails.dmi'
	color_src = NONE

/datum/sprite_accessory/tails_animated/vox/green
	name = "green"
	icon_state = "green"

/datum/sprite_accessory/tails_animated/vox/crimson
	name = "crimson"
	icon_state = "crimson"

/*/datum/sprite_accessory/vox_tails/dgrvox
	name = "dgrvox"
	icon_state = "dgrvox"

/datum/sprite_accessory/vox_tails/brnvox
	name = "brnvox"
	icon_state = "brnvox"

/datum/sprite_accessory/vox_tails/gryvox
	name = "gryvox"
	icon_state = "gryvox"

/datum/sprite_accessory/vox_tails/emdvox
	name = "emdvox"
	icon_state = "emdvox"

/datum/sprite_accessory/vox_tails/azevox
	name = "azevox"
	icon_state = "azevox"

/datum/sprite_accessory/vox_tails/aurvox
	name = "aurvox"
	icon_state = "aurvox"
*/

/datum/sprite_accessory/vox_body_markings
	icon = 'icons/mob/species/vox/body_markings.dmi'
	color_blend_mode = "add"

/datum/sprite_accessory/vox_body_markings/none
	name = "None"

/datum/sprite_accessory/vox_body_markings/heart
	name = "Heart"
	icon_state = "heart"
	body_slots = list(BODY_ZONE_R_ARM)

/datum/sprite_accessory/vox_body_markings/hive
	name = "Hive"
	icon_state = "hive"
	body_slots = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/vox_body_markings/nightling
	name = "Nightling"
	icon_state = "nightling"
	body_slots = list(BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/datum/sprite_accessory/vox_body_markings/tiger_body
	name = "Tiger-stripe"
	icon_state = "tiger"
	body_slots = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/datum/sprite_accessory/vox_tail_markings
	icon = 'icons/mob/species/vox/tail_markings.dmi'
	color_src = MUTCOLORS_SECONDARY
	color_blend_mode = "add"

/datum/sprite_accessory/vox_tail_markings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/vox_tail_markings/bands
	name = "Bands"
	icon_state = "bands"

/datum/sprite_accessory/vox_tail_markings/tip
	name = "Tip"
	icon_state = "tip"

/datum/sprite_accessory/vox_tail_markings/stripe
	name = "Stripe"
	icon_state = "stripe"

/datum/sprite_accessory/vox_tail_markings_animated
	icon = 'icons/mob/species/vox/tail_markings.dmi'
	color_src = MUTCOLORS_SECONDARY
	color_blend_mode = "add"

/datum/sprite_accessory/vox_tail_markings_animated/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/vox_tail_markings_animated/bands
	name = "Bands"
	icon_state = "bands"

/datum/sprite_accessory/vox_tail_markings_animated/tip
	name = "Tip"
	icon_state = "tip"

/datum/sprite_accessory/vox_tail_markings_animated/stripe
	name = "Stripe"
	icon_state = "stripe"

