// The random spawn proc on the antag datum will handle announcing the spawn and whatnot.
/datum/event/random_antag/announce()
	return

/datum/event/random_antag/start()
	var/list/valid_types = list()
	var/all_antagonist_types = decls_repository.get_decls_of_subtype(/decl/special_role)
	for(var/antag_type in all_antagonist_types)
		var/decl/special_role/antag = all_antagonist_types[antag_type]
		if(antag.flags & ANTAG_RANDSPAWN)
			valid_types |= antag
	if(valid_types.len)
		var/decl/special_role/antag = pick(valid_types)
		antag.attempt_random_spawn()