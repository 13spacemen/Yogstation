/*ALL DNA, SPECIES, AND GENETICS-RELATED DEFINES GO HERE*/

#define CHECK_DNA_AND_SPECIES(C) if((!(C.dna)) || (!(C.dna.species))) return

//Defines copying names of mutations in all cases, make sure to change this if you change mutation's type
#define HULK		/datum/mutation/human/hulk
#define XRAY		/datum/mutation/human/thermal/x_ray
#define SPACEMUT	/datum/mutation/human/space_adaptation
#define HEATMUT		/datum/mutation/human/heat_adaptation
#define TK			/datum/mutation/human/telekinesis
#define NERVOUS		/datum/mutation/human/nervousness
#define EPILEPSY	/datum/mutation/human/epilepsy
#define MUTATE		/datum/mutation/human/bad_dna
#define COUGH		/datum/mutation/human/cough
#define DWARFISM	/datum/mutation/human/dwarfism
#define GIGANTISM	/datum/mutation/human/gigantism
#define CLOWNMUT	/datum/mutation/human/clumsy
#define TOURETTES	/datum/mutation/human/tourettes
#define DEAFMUT		/datum/mutation/human/deaf
#define BLINDMUT	/datum/mutation/human/blind
#define RACEMUT		/datum/mutation/human/race
#define BADSIGHT	/datum/mutation/human/nearsight
#define LASEREYES	/datum/mutation/human/laser_eyes
#define CHAMELEON	/datum/mutation/human/chameleon
#define SUPER_CHAMELEON		/datum/mutation/human/chameleon/super
#define WACKY		/datum/mutation/human/wacky
#define MUT_MUTE	/datum/mutation/human/mute
#define SMILE		/datum/mutation/human/smile
#define STONER		/datum/mutation/human/stoner
#define UNINTELLIGIBLE		/datum/mutation/human/unintelligible
#define SWEDISH		/datum/mutation/human/swedish
#define CHAV		/datum/mutation/human/chav
#define ELVIS		/datum/mutation/human/elvis
#define RADIOACTIVE	/datum/mutation/human/radioactive
#define RAVENOUS	/datum/mutation/human/ravenous
#define RADPROOF	/datum/mutation/human/radproof
#define SAPBLOOD	/datum/mutation/human/sapblood
#define GLOWY		/datum/mutation/human/glow
#define ANTIGLOWY	/datum/mutation/human/glow/anti
#define TELEPATHY	/datum/mutation/human/telepathy
#define FIREBREATH	/datum/mutation/human/firebreath
#define VOID		/datum/mutation/human/void
#define STRONG    	/datum/mutation/human/strong
#define FIRESWEAT	/datum/mutation/human/fire
#define THERMAL		/datum/mutation/human/thermal
#define ANTENNA		/datum/mutation/human/antenna
#define PARANOIA	/datum/mutation/human/paranoia
#define INSULATED	/datum/mutation/human/insulated
#define SHOCKTOUCH	/datum/mutation/human/shock
#define SHOCKTOUCHFAR		/datum/mutation/human/shock/far
#define OLFACTION	/datum/mutation/human/olfaction
#define ACIDFLESH	/datum/mutation/human/acidflesh
#define BADBLINK	/datum/mutation/human/badblink
#define SPASTIC		/datum/mutation/human/spastic
#define EXTRASTUN	/datum/mutation/human/extrastun
#define GELADIKINESIS		/datum/mutation/human/geladikinesis
#define CRYOKINESIS /datum/mutation/human/cryokinesis
#define ACIDSPIT	/datum/mutation/human/acidspit
#define CEREBRAL	/datum/mutation/human/cerebral
#define THICKSKIN	/datum/mutation/human/thickskin
#define DENSEBONES	/datum/mutation/human/densebones
#define RADIANTBURST	/datum/mutation/human/radiantburst


#define UI_CHANGED "ui changed"
#define UE_CHANGED "ue changed"
#define UF_CHANGED "uf changed"

#define CHAMELEON_MUTATION_DEFAULT_TRANSPARENCY 255
#define CHAMELEON_MUTATION_MINIMUM_TRANSPARENCY 30


// String identifiers for associative list lookup

//Types of usual mutations
#define	POSITIVE 			1
#define	NEGATIVE			2
#define	MINOR_NEGATIVE		4


//Mutation classes. Normal being on them, extra being additional mutations with instability and other being stuff you dont want people to fuck with like wizard mutate
#define MUT_NORMAL 1
#define MUT_EXTRA 2
#define MUT_OTHER 3

//DNA - Because fuck you and your magic numbers being all over the codebase.
#define DNA_BLOCK_SIZE				3

#define DNA_BLOCK_SIZE_COLOR DEFAULT_HEX_COLOR_LEN

#define DNA_UNI_IDENTITY_BLOCKS		7
#define DNA_HAIR_COLOR_BLOCK		1
#define DNA_FACIAL_HAIR_COLOR_BLOCK	2
#define DNA_SKIN_TONE_BLOCK			3
#define DNA_EYE_COLOR_BLOCK			4
#define DNA_GENDER_BLOCK			5
#define DNA_FACIAL_HAIR_STYLE_BLOCK	6
#define DNA_HAIR_STYLE_BLOCK		7

/// This number needs to equal the total number of DNA blocks
#define DNA_FEATURE_BLOCKS 28

#define DNA_MUTANT_COLOR_BLOCK 1
#define DNA_ETHEREAL_COLOR_BLOCK 2
#define DNA_LIZARD_MARKINGS_BLOCK 3
#define DNA_LIZARD_TAIL_BLOCK 4
#define DNA_SNOUT_BLOCK 5
#define DNA_HORNS_BLOCK 6
#define DNA_FRILLS_BLOCK 7
#define DNA_SPINES_BLOCK 8
#define DNA_HUMAN_TAIL_BLOCK 9
#define DNA_EARS_BLOCK 10
#define DNA_MOTH_WINGS_BLOCK 11
#define DNA_MUSHROOM_CAPS_BLOCK 12
#define DNA_POD_HAIR_BLOCK 13
//Yog specific DNA Blocks
#define DNA_POD_FLOWER_BLOCK 14
#define DNA_POLY_TAIL_BLOCK 15
#define DNA_POLY_TEETH_BLOCK 16
#define DNA_POLY_DOME_BLOCK 17
#define DNA_POLY_DORSAL_BLOCK 18
#define DNA_ETHEREAL_MARK_BLOCK 19
#define DNA_PRETERNIS_WEATHERING_BLOCK 20
#define DNA_PRETERNIS_ANTENNA_BLOCK 21
#define DNA_PRETERNIS_EYE_BLOCK 22
#define DNA_VOX_QUILLS_BLOCK 23
#define DNA_VOX_FACIAL_QUILLS_BLOCK 24
#define DNA_VOX_TAIL_MARKINGS_BLOCK 25
#define DNA_VOX_BODY_MARKINGS_BLOCK 26
#define DNA_VOX_BODY_BLOCK 27
#define DNA_MUTANT_COLOR_SECONDARY 28

#define DNA_SEQUENCE_LENGTH			4
#define DNA_MUTATION_BLOCKS			8
#define DNA_UNIQUE_ENZYMES_LEN		32

//Transformation proc stuff
#define TR_KEEPITEMS	(1<<0)
#define TR_KEEPVIRUS	(1<<1)
#define TR_KEEPDAMAGE	(1<<2)
/// hashing names (e.g. monkey(e34f)) (only in monkeyize)
#define TR_HASHNAME		(1<<3)
#define TR_KEEPIMPLANTS	(1<<4)
/// changelings shouldn't edit the DNA's SE when turning into a monkey
#define TR_KEEPSE		(1<<5)
#define TR_DEFAULTMSG	(1<<6)
#define TR_KEEPORGANS	(1<<8)
#define TR_KEEPSTUNS	(1<<9)
#define TR_KEEPREAGENTS	(1<<10)


#define CLONER_FRESH_CLONE "fresh"
#define CLONER_MATURE_CLONE "mature"

//species traits for mutantraces
#define MUTCOLORS		1
#define HAIR			2
#define FACEHAIR		3
#define EYECOLOR		4
#define LIPS			5
#define NOBLOOD			6
#define NOTRANSSTING	7
/// Used if we want the mutant colour to be only used by mutant bodyparts. Don't combine this with MUTCOLORS, or it will be useless.
#define MUTCOLORS_PARTSONLY	8
#define NOZOMBIE		9
/// If we want a race to have a standard color (for now this is only polysmorphs)
#define NOCOLORCHANGE   10
/// Uses weird leg sprites. Optional for Lizards, required for ashwalkers. Don't give it to other races unless you make sprites for this (see human_parts_greyscale.dmi)
#define DIGITIGRADE		11
#define NO_UNDERWEAR	12
#define NOLIVER			13
#define NOSTOMACH		14
#define NO_DNA_COPY     15
#define DRINKSBLOOD		16
#define NOFLASH			17
/// Use this if you want to change the race's color without the player being able to pick their own color. AKA special color shifting
#define DYNCOLORS		18
/// Forced genders
#define AGENDER			19
#define FGENDER         20
#define MGENDER	        21
/// Do not draw eyes or eyeless overlay
#define NOEYESPRITES	22
/// Used for determining which wounds are applicable to this species.
/// if we have flesh (can suffer slash/piercing/burn wounds, requires they don't have NOBLOOD)
#define HAS_FLESH	23
/// if we have bones (can suffer bone wounds)
#define HAS_BONE	24
/// Can't be husked.
#define NOHUSK			25
/// have no mouth to ingest/eat with
#define NOMOUTH			26
/// has a tail
#define HAS_TAIL		27
#define NONANITES		28
#define HAIRCOLOR		29
#define FACEHAIRCOLOR	30
#define MUTCOLORS_SECONDARY		31

//organ slots
#define ORGAN_SLOT_BRAIN "brain"
#define ORGAN_SLOT_APPENDIX "appendix"
#define ORGAN_SLOT_STOMACH "stomach"
#define ORGAN_SLOT_EARS "ears"
#define ORGAN_SLOT_EYES "eye_sight"
#define ORGAN_SLOT_LUNGS "lungs"
#define ORGAN_SLOT_HEART "heart"
#define ORGAN_SLOT_ZOMBIE "zombie_infection"
#define ORGAN_SLOT_LIVER "liver"
#define ORGAN_SLOT_TONGUE "tongue"
#define ORGAN_SLOT_VOICE "vocal_cords"
#define ORGAN_SLOT_ADAMANTINE_RESONATOR "adamantine_resonator"
#define ORGAN_SLOT_TAIL "tail"
#define ORGAN_SLOT_PARASITE_EGG "parasite_egg"

//implants
#define ORGAN_SLOT_BRAIN_IMPLANT "brain_implant"
#define ORGAN_SLOT_HUD "eye_hud"
#define ORGAN_SLOT_BREATHING_TUBE "breathing_tube"
#define ORGAN_SLOT_TORSO_IMPLANT "torso_implant"
#define ORGAN_SLOT_HEART_AID "heartdrive"
#define ORGAN_SLOT_STOMACH_AID "stomach_aid"
#define ORGAN_SLOT_RIGHT_ARM_AUG "r_arm_device"
#define ORGAN_SLOT_LEFT_ARM_AUG "l_arm_device"
#define ORGAN_SLOT_RIGHT_LEG_AUG "r_leg_device"
#define ORGAN_SLOT_LEFT_LEG_AUG "l_leg_device"

//organ defines
#define STANDARD_ORGAN_THRESHOLD 	100
#define STANDARD_ORGAN_HEALING 		0.001
/// designed to fail organs when left to decay for ~15 minutes
#define STANDARD_ORGAN_DECAY		0.00222

//used for the can_chromosome var on mutations
#define CHROMOSOME_NEVER 0
#define CHROMOSOME_NONE 1
#define CHROMOSOME_USED 2

#define G_MALE 1
#define G_FEMALE 2
#define G_PLURAL 3

// Defines for used in creating "perks" for the species preference pages.
/// A key that designates UI icon displayed on the perk.
#define SPECIES_PERK_ICON "ui_icon"
/// A key that designates the name of the perk.
#define SPECIES_PERK_NAME "name"
/// A key that designates the description of the perk.
#define SPECIES_PERK_DESC "description"
/// A key that designates what type of perk it is (see below).
#define SPECIES_PERK_TYPE "perk_type"

// The possible types each perk can be.
// Positive perks are shown in green, negative in red, and neutral in grey.
#define SPECIES_POSITIVE_PERK "positive"
#define SPECIES_NEGATIVE_PERK "negative"
#define SPECIES_NEUTRAL_PERK "neutral"
