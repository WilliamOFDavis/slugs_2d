extends CharacterBody2D

class_name Slug

var jumping = false
var gravity: float = 50.0
var is_zooming_out: bool = false
var airborne: bool = false
var maybe_airborne: bool = false
var current_weapon: Weapon
@onready var velocity_component: VelocityComponent = $VelocityComponent
# Called when the node enters the scene tree for the first time.

signal shoot_projectile(projectile, start_position, direction, shooter)

func _ready() -> void:
	$InputComponent.connect("shoot_weapon", shoot_weapon)
	$AnimatedSprite2D.play("walk")

func set_current_weapon(new_weapon: Weapon) -> void:
	current_weapon = new_weapon
	$WeaponSprite.texture = current_weapon.weapon_texture

func hide_weapon() -> void:
	$WeaponSprite.visible = false

func show_weapon() -> void:
	$WeaponSprite.visible = true

func shoot_weapon(direction_to_mouse: Vector2) -> void:
	shoot_projectile.emit(current_weapon.projectile, global_position + Vector2(0,8), direction_to_mouse, self)

func hit():
	global_position = Vector2(0,-100)
	
func _physics_process(_delta: float) -> void:
	velocity = velocity_component.get_velocity()
	move_and_slide()
