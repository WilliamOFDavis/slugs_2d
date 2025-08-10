extends CharacterBody2D

class_name Slug

var jumping = false
var gravity: float = 50.0
var is_zooming_out: bool = false
var airborne: bool = false
var maybe_airborne: bool = false
var current_weapon: Weapon
var current_inventory: Array[Weapon]
var weapon_index: int = 0
var active_turn: bool = false
@onready var velocity_component: VelocityComponent = $VelocityComponent
# Called when the node enters the scene tree for the first time.

signal turn_over
signal shoot_projectile(projectile, start_position, direction, shooter)

func _ready() -> void:
	$InputComponent.connect("shoot_weapon", shoot_weap)
	$AnimatedSprite2D.play("walk")

func begin_turn() -> void:
	active_turn = true

func end_turn() -> void:
	active_turn = false
	turn_over.emit()

func set_inventory(inventory: Array[Weapon]) -> void:
	current_inventory = inventory

func set_current_weapon(new_weapon: Weapon) -> void:
	current_weapon = new_weapon
	$WeaponSprite.texture = current_weapon.weapon_texture

func switch_weapon() -> void:
	set_current_weapon(current_inventory[weapon_index % current_inventory.size()])
	weapon_index += 1

func hide_weapon() -> void:
	$WeaponSprite.visible = false

func show_weapon() -> void:
	$WeaponSprite.visible = true

func shoot_weap(direction_to_mouse: Vector2) -> void:
	print("Player: shoot_weapon called")
	if current_weapon != null:
		print("Player: Emitting shoot_projectile signal")
		shoot_projectile.emit(current_weapon.projectile, global_position, direction_to_mouse, self)

func hit():
	pass

func _physics_process(_delta: float) -> void:
	velocity = velocity_component.get_velocity()
	move_and_slide()


func _on_input_component_switch_weapon() -> void:
	switch_weapon()
