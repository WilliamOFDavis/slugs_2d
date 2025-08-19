extends Resource

class_name Inventory

@export var weapons: Array[Weapon]

func initialise_inventory() -> void:
	for i in range(weapons.size()):
		weapons[i] = weapons[i].duplicate(true)

func get_inventory() -> Array[Weapon]:
	return weapons
