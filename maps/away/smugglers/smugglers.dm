#include "smugglers_areas.dm"
#include "../mining/mining_areas.dm"
/obj/effect/overmap/visitable/sector/smugglers
	name = "asteroid station"
	desc = "A small station built into an asteroid. No radio traffic detected."
	icon_state = "object"
	initial_generic_waypoints = list(
		"nav_smugglers",
		"nav_smugglers_antag"
	)

/datum/map_template/ruin/away_site/smugglers
	name = "Smugglers' Base"
	description = "Yarr."
	suffixes = list("smugglers/smugglers.dmm")
	cost = 1
	level_data_type = /datum/level_data/mining_level
	area_usage_test_exempted_root_areas = list(/area/smugglers)
	apc_test_exempt_areas = list(
		/area/smugglers/base = NO_SCRUBBER|NO_VENT,
		/area/smugglers/dorms = NO_SCRUBBER|NO_VENT,
		/area/smugglers/office = NO_SCRUBBER|NO_VENT
	)

/obj/effect/shuttle_landmark/nav_asteroid_base/nav1
	name = "Abandoned Asteroid Base Navpoint #1"
	landmark_tag = "nav_smugglers"

/obj/effect/shuttle_landmark/nav_asteroid_base/nav2
	name = "Abandoned Asteroid Base Navpoint #2"
	landmark_tag = "nav_smugglers_antag"
	flags = SLANDMARK_FLAG_AUTOSET

/obj/item/paper/smug_1
	name = "suspicios note"
	info = "This one goes to Nyx, Tranist station 3, dock 14. Ask Dr. Jensen.<BR> <b>Ask no less than 4000cr!</b>"

/obj/item/paper/smug_2
	name = "suspicious note"
	info = "That scaly fuckface will be curious about what we got from that mine storage last week."

/obj/item/paper/smug_3
	name = "suspicious note"
	info = "If I catch any of you stupid asses smoking near canisters again, you'll end up near Tony behind that rocky wall!"

/obj/item/paper/smug_4
	name = "suspicious note"
	info = "<list>\[*] Special order +3000 th.\[*] Some handguns, used +800 th.\[*] Another uranium delivery  +2450 th.\[*] Two human hearts in freezer +1000 th. for each <small>(Make it 1500, shit is gross)</small>\[*] Some food and pills -340 th.</list>"

/obj/item/paper/smug_5
	name = "suspicious note"
	info = "Jacky, he keeps holding our shares. I'll get fucker down when we'll be back from next flight. <i>Tony</i>"

/obj/structure/closet/smuggler
	name = "suspicious locker"
	desc = "Rusty, greasy old locker, smelling of cigarettes and cheap alcohol."

/obj/structure/closet/smuggler/WillContain()
	return list(
		/obj/random/ammo,
		/obj/random/contraband,
		/obj/random/contraband,
		/obj/random/drinkbottle,
		/obj/random/drinkbottle,
		/obj/random/cash,
		/obj/random/cash,
		/obj/random/cash,
		/obj/random/smokes,
		new /datum/atom_creator/simple(/obj/item/chems/syringe, 50),
		new /datum/atom_creator/simple(/obj/item/chems/syringe/steroid, 10),
		new /datum/atom_creator/simple(/obj/item/chems/syringe/steroid, 10),
		new /datum/atom_creator/weighted(list(/obj/item/chems/drinks/cans/cola, /obj/item/chems/drinks/cans/waterbottle, /obj/item/chems/drinks/cans/dr_gibb)),
		new /datum/atom_creator/simple(/obj/item/clothing/glasses/eyepatch, 30),
		new /datum/atom_creator/simple(/obj/item/clothing/gloves/thick/duty, 80),
		new /datum/atom_creator/simple(/obj/item/clothing/mask/balaclava/tactical, 30))

/obj/random/ore
	name = "random ore"
	desc = "This is a random ore."
	icon_state = "lump"
	icon = 'icons/obj/materials/ore.dmi'

/obj/random/ore_smug/spawn_choices()
	return subtypesof(/obj/item/stack/material/ore)

/obj/random/ammo_magazine_smug
	name = "Random Ammo Magazine"
	desc = "This is smuggler's random ammo magazine."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "magnum"

/obj/random/ammo_magazine_smug/spawn_choices()
	var/static/list/spawnable_choices = list(
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/speedloader,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle
	)
	return spawnable_choices

/obj/structure/closet/crate/plastic_smug_ammo
	name = "dirty plastic crate"
	desc = "Dirty and scrtached plastic crate."
	closet_appearance = /decl/closet_appearance/crate/plastic

/obj/structure/closet/crate/plastic_smug_ammo/WillContain()
	return list(
		/obj/random/ammo_magazine_smug,
		/obj/random/ammo_magazine_smug,
		/obj/random/ammo_magazine_smug,
		/obj/random/ammo_magazine_smug,
		/obj/random/ammo_magazine_smug)

/obj/structure/closet/crate/plastic_smug_weapons
	name = "dirty plastic crate"
	desc = "Dirty and scrtached plastic crate."
	closet_appearance = /decl/closet_appearance/crate/plastic

/obj/structure/closet/crate/plastic_smug_weapons/WillContain()
	return list(
		/obj/random/handgun,
		/obj/random/handgun,
		/obj/random/handgun,
		/obj/random/projectile,
		/obj/random/projectile)
