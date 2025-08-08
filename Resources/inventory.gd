extends Resource

class_name Inventory

@export var weapons: Array[Weapon]

func get_inventory() -> Array[Weapon]:
	return weapons
