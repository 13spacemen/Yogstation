//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/make_datum_references_lists()
	//hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/hair, GLOB.hair_styles_list, GLOB.hair_styles_male_list, GLOB.hair_styles_female_list)
	//facial hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/facial_hair, GLOB.facial_hair_styles_list, GLOB.facial_hair_styles_male_list, GLOB.facial_hair_styles_female_list)
	//underwear
	init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear, GLOB.underwear_list, GLOB.underwear_m, GLOB.underwear_f)
	//undershirt
	init_sprite_accessory_subtypes(/datum/sprite_accessory/undershirt, GLOB.undershirt_list, GLOB.undershirt_m, GLOB.undershirt_f)
	//socks
	init_sprite_accessory_subtypes(/datum/sprite_accessory/socks, GLOB.socks_list)
	//bodypart accessories (blizzard intensifies)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/body_markings, GLOB.body_markings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/lizard, GLOB.tails_list_lizard)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails_animated/lizard, GLOB.animated_tails_list_lizard)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/human, GLOB.tails_list_human)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails_animated/human, GLOB.animated_tails_list_human)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/polysmorph, GLOB.tails_list_polysmorph)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts, GLOB.snouts_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/horns,GLOB.horns_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, GLOB.ears_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, GLOB.wings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings_open, GLOB.wings_open_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/frills, GLOB.frills_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/spines, GLOB.spines_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/spines_animated, GLOB.animated_spines_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/legs, GLOB.legs_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/caps, GLOB.caps_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/moth_wings, GLOB.moth_wings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/moth_wingsopen, GLOB.moth_wingsopen_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/teeth, GLOB.teeth_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/dome, GLOB.dome_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/dorsal_tubes, GLOB.dorsal_tubes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ethereal_mark, GLOB.ethereal_mark_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/pod_hair, GLOB.pod_hair_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/pod_flower, GLOB.pod_flower_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_screens, GLOB.ipc_screens_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_antennas, GLOB.ipc_antennas_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_chassis, GLOB.ipc_chassis_list)
	// Vox bodyparts
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_bodies, GLOB.vox_bodies_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_quills, GLOB.vox_quills_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_facial_quills, GLOB.vox_facial_quills_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_eyes, GLOB.vox_eyes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_tails, GLOB.vox_tails_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_body_markings, GLOB.vox_body_markings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_tail_markings, GLOB.vox_tail_markings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails_animated/vox, GLOB.animated_vox_tails_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vox_tail_markings_animated, GLOB.animated_vox_tail_markings_list)




	//Species
	for(var/spath in subtypesof(/datum/species))
		var/datum/species/S = new spath()
		GLOB.species_list[S.id] = spath

	//Surgeries
	for(var/path in subtypesof(/datum/surgery))
		GLOB.surgeries_list += new path()

	// Hair Gradients - Initialise all /datum/sprite_accessory/hair_gradient into an list indexed by gradient-style name
	for(var/path in subtypesof(/datum/sprite_accessory/hair_gradient))
		var/datum/sprite_accessory/hair_gradient/H = new path()
		GLOB.hair_gradients_list[H.name] = H

	// Keybindings
	init_keybindings()

	GLOB.emote_list = init_emote_list()
	//Skillcapes
	for(var/path in subtypesof(/datum/skillcape))
		var/datum/skillcape/A = new path()
		if(!A.id)
			continue
		GLOB.skillcapes[A.id] = A

	init_crafting_recipes()
	init_crafting_recipes_atoms()

/// Inits crafting recipe lists.
/proc/init_crafting_recipes(list/crafting_recipes)
	for(var/path in subtypesof(/datum/crafting_recipe))
		var/datum/crafting_recipe/recipe = new path()
		var/is_cooking = (recipe.category in GLOB.crafting_category_food)
		recipe.reqs = sort_list(recipe.reqs, GLOBAL_PROC_REF(cmp_crafting_req_priority))
		if(recipe.name != "" && recipe.result)
			if(is_cooking)
				GLOB.cooking_recipes += recipe
			else
				GLOB.crafting_recipes += recipe

/// Inits atoms used in crafting recipes.
/proc/init_crafting_recipes_atoms()
	var/list/recipe_lists = list(
		GLOB.crafting_recipes,
		GLOB.cooking_recipes
	)
	var/list/atom_lists = list(
		GLOB.crafting_recipes_atoms,
		GLOB.cooking_recipes_atoms
	)

	for(var/recipe_list in recipe_lists)
		for(var/datum/crafting_recipe/recipe as anything in recipe_list)
			var/list_index = recipe_lists.Find(recipe_list)
			// Result
			if(!(recipe.result in atom_lists[list_index]))
				atom_lists[list_index] += recipe.result
			// Ingredients
			for(var/atom/req_atom as anything in recipe.reqs)
				if(!(req_atom in atom_lists[list_index]))
					atom_lists[list_index] += req_atom
			// Tools
			for(var/atom/req_atom as anything in recipe.tool_paths)
				if(!(req_atom in atom_lists[list_index]))
					atom_lists[list_index] += req_atom

//creates every subtype of prototype (excluding prototype) and adds it to list L.
//if no list/L is provided, one is created.
/proc/init_subtypes(prototype, list/L)
	if(!istype(L))
		L = list()
	for(var/path in subtypesof(prototype))
		L += new path()
	return L

//returns a list of paths to every subtype of prototype (excluding prototype)
//if no list/L is provided, one is created.
/proc/init_paths(prototype, list/L)
	if(!istype(L))
		L = list()
		for(var/path in subtypesof(prototype))
			L+= path
		return L
