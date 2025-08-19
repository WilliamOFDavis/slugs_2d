extends Resource

class_name Weapon

enum aiming_methods {AIMING_METHOD_CLICK, AIMING_METHOD_SHOOT, AIMING_METHOD_AIRSTRIKE}
enum weapon_types {WEAPON_TYPE_SHOOTABLE, WEAPON_TYPE_THROWABLE, WEAPON_TYPE_CALL_IN}
@export var name: String
@export var weapon_texture: Texture
@export var projectile: PackedScene
@export var projectile_count: int = 1
@export var projectile_release_delay: float = 0.0
@export var projectile_x_spread: float = 0.0
@export var aiming_method: aiming_methods = aiming_methods.AIMING_METHOD_CLICK
@export var weapon_type: weapon_types = weapon_types.WEAPON_TYPE_SHOOTABLE
@export var max_ammo: int = 3

var current_ammo: int

func _init() -> void:
	current_ammo = max_ammo


func decrement_ammo() -> void:
	current_ammo -= 1
