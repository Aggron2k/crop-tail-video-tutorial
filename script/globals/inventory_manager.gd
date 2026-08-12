extends Node
var inventory: Dictionary = Dictionary ()

signal inventory_change

func add_collectable(collectable_name: String) -> void:
	inventory.get_or_add(collectable_name)

	if inventory[collectable_name] == null:
		inventory[collectable_name] = 1
	else:
		inventory[collectable_name] += 1

	inventory_change.emit()

func remove_collectable(collactable_name: String) -> void:
	if inventory[collactable_name] == null:
		inventory[collactable_name] = 0
	else:
		if inventory[collactable_name] > 0:
			inventory[collactable_name] -= 1
	
	inventory_change.emit()
