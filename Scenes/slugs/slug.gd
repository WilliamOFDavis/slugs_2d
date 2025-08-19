extends CharacterBody2D

class_name Slug

var jumping = false
var gravity: float = 50.0
var is_zooming_out: bool = false
var airborne: bool = false
var maybe_airborne: bool = false
var current_weapon: Weapon
var current_team: Team
var current_inventory: Inventory
var weapon_index: int = 0
var active_turn: bool = false
var health: int = 100: 
	set(new_health):
		if new_health <= 0: 
			health = 100
			death()
		else:
			health = new_health
			
@onready var camera: Camera2D = $Camera2D
@onready var velocity_component: VelocityComponent = $VelocityComponent
# Called when the node enters the scene tree for the first time.

signal turn_over
signal shoot_projectile(projectile, start_position, direction, shooter)

func _ready() -> void:
	$InputComponent.connect("shoot_weapon", shoot_weap)
	$AnimatedSprite2D.play("walk")

func set_team(team: Team) -> void:
	current_team = team
	$AnimatedSprite2D.material = $AnimatedSprite2D.material.duplicate()
	$AnimatedSprite2D.material.set_shader_parameter("team_color", team.team_color)

func activate_slug() -> void:
	active_turn = true
	camera.enabled = true

func deactivate_slug() -> void:
	active_turn = false
	camera.enabled = false

func begin_turn() -> void:
	activate_slug()

func end_turn() -> void:
	deactivate_slug()
	turn_over.emit()

func set_inventory(inventory: Inventory) -> void:
	current_inventory = inventory

func set_current_weapon(new_weapon: Weapon) -> void:
	current_weapon = new_weapon
	if current_weapon.current_ammo > 0:
		$WeaponSprite.texture = current_weapon.weapon_texture
		show_weapon()
	else:
		hide_weapon()

func switch_weapon() -> void:
	if current_inventory.get_inventory().size() > 0:
		set_current_weapon(current_inventory.get_inventory()[weapon_index % current_inventory.get_inventory().size()])
		weapon_index += 1

func hide_weapon() -> void:
	$WeaponSprite.visible = false

func show_weapon() -> void:
	$WeaponSprite.visible = true

func shoot_weap(direction_to_mouse: Vector2) -> void:
	if current_weapon != null and current_weapon.current_ammo > 0:
		shoot_projectile.emit(current_weapon.projectile, global_position, direction_to_mouse, self)
		current_weapon.decrement_ammo()
	if current_weapon != null and current_weapon.current_ammo <= 0:
		hide_weapon()
		current_inventory.get_inventory().erase(current_weapon)
		weapon_index -= 1
		switch_weapon()
		

func hit(shooter: Slug, damage:int = 0, knockback_direction: Vector2 = Vector2.ZERO):
	if shooter.current_team != current_team:
		health -= damage
		velocity_component.knock_back(knockback_direction)
	
func death() -> void:
	position = Vector2(0,-1000)

func _physics_process(_delta: float) -> void:
	velocity = velocity_component.get_velocity()
	move_and_slide()
	

func _on_input_component_switch_weapon() -> void:
	switch_weapon()
