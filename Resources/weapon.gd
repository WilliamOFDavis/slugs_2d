extends Resource

class_name Weapon

enum aiming_methods {AIMING_METHOD_CLICK, AIMING_METHOD_SHOOT, AIMING_METHOD_AIRSTRIKE}

@export var name: String
@export var weapon_texture: Texture
@export var projectile: PackedScene
@export var projectile_count: int = 1
@export var projectile_release_delay: float = 0.0
@export var projectile_x_spread: float = 0.0
@export var aiming_method: aiming_methods
@export var max_ammo: int = 3

var current_ammo: int

func _init() -> void:
	current_ammo = max_ammo

func decrement_ammo() -> void:
	current_ammo -= 1
