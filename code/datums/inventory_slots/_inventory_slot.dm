/datum/inventory_slot

	var/slot_name = "Unknown"
	var/slot_id
	var/slot_state
	var/slot_dir

	var/ui_loc
	var/ui_label
	var/overlay_slot

	var/obj/item/_holding
	var/list/drop_slots_on_unequip
	var/covering_flags = 0
	var/covering_slot
	var/can_be_hidden = FALSE
	var/skip_on_inventory_display = FALSE
	var/skip_on_strip_display = FALSE
	var/requires_slot_flags
	var/requires_organ_tag

/datum/inventory_slot/Destroy(force)
	_holding = null
	return ..()

/datum/inventory_slot/proc/equipped(var/mob/living/user, var/obj/item/prop, var/redraw_mob = TRUE, var/delete_old_item = TRUE)

	// Clear up any preexisting item.
	var/atom/movable/held = get_equipped_item()
	if(held)
		user.drop_from_inventory(held)
		if(delete_old_item && !QDELETED(held))
			qdel(held)

	// Set slot vars.
	set_slot(prop)
	prop.forceMove(user)
	prop.hud_layerise()
	prop.equipped(user, slot_id)

	// Redraw overlays if needed.
	update_overlay(user, prop, redraw_mob)
	return TRUE

/datum/inventory_slot/proc/unequipped(var/mob/living/user, var/obj/item/prop, var/redraw_mob = TRUE)
	SHOULD_CALL_PARENT(TRUE)
	clear_slot()
	for(var/slot in drop_slots_on_unequip)
		var/obj/item/thing = user.get_equipped_item(slot)
		if(thing)
			user.drop_from_inventory(thing)
	update_overlay(user, prop, redraw_mob)
	return TRUE

/datum/inventory_slot/proc/update_overlay(var/mob/living/user, var/obj/item/prop, var/redraw_mob = TRUE)
	return

/datum/inventory_slot/proc/set_slot(var/obj/item/prop)
	_holding = prop
	if(_holding)
		_holding.screen_loc = ui_loc

/datum/inventory_slot/proc/clear_slot()
	if(_holding)
		_holding.screen_loc = null
	_holding = null

/datum/inventory_slot/proc/get_covering_item(var/mob/user)
	if(covering_slot)
		return user.get_equipped_item(covering_slot)

/datum/inventory_slot/proc/get_covering_flags(var/mob/user)
	return covering_flags

/datum/inventory_slot/proc/get_equipped_item()
	return _holding

/datum/inventory_slot/proc/get_equipped_name()
	return _holding?.name

/datum/inventory_slot/proc/hide_slot()
	if(_holding)
		_holding.screen_loc = null

/datum/inventory_slot/proc/show_slot()
	if(_holding)
		_holding.screen_loc = ui_loc

/datum/inventory_slot/proc/check_has_required_organ(var/mob/user)
	if(!requires_organ_tag)
		return TRUE
	if(islist(requires_organ_tag))
		for(var/bp in requires_organ_tag)
			if(user.get_organ(bp))
				return TRUE
	return user.get_organ(requires_organ_tag)

/datum/inventory_slot/proc/clone()
	return new type

/datum/inventory_slot/proc/equivalent_to(var/datum/inventory_slot/other_slot)
	if(!istype(other_slot) || QDELETED(other_slot) || QDELETED(src))
		return FALSE
	if(other_slot.type != type)
		return FALSE
	if(other_slot.slot_id != slot_id)
		return FALSE
	if(other_slot.slot_name != slot_name)
		return FALSE
	if(other_slot.slot_state != slot_state)
		return FALSE
	if(other_slot.ui_loc != ui_loc)
		return FALSE
	return TRUE

/datum/inventory_slot/proc/can_equip_to_slot(var/mob/user, var/obj/item/prop, var/slot, var/disable_warning, var/force)
	// Check that the slot is valid and free
	if(_holding || !slot_id || slot != slot_id)
		return FALSE
	// Check that the item has the appropriate flags.
	if(!isnull(requires_slot_flags) && !(requires_slot_flags & prop.slot_flags))
		return FALSE
	// Other subtypes implement their own checking. We're good for now.
	return TRUE

/datum/inventory_slot/proc/get_examined_string(mob/owner, mob/user, distance, hideflags, decl/pronouns/pronouns)
	if(_holding)
		return "[pronouns.He] [pronouns.is] wearing [_holding.get_examine_line()]."
