extends Node2D

class_name VelocityComponent

@onready var parent = get_parent()

@export var slug_state_machine: StateMachine
@export var sprite: Node2D
@export var speed: float = 200.0
@export var gravity: float = 150.0
@export var velocity: Vector2
@export var direction: Vector2 = Vector2.ZERO

var knockback_force: float =  500.0
var knockback_velocity: Vector2


func set_x_direction(axis: float) -> void:
	direction.x = axis
	if direction.x == 1:
		sprite.flip_h = false
	elif direction.x == -1:
		sprite.flip_h = true
	if knockback_velocity.length() < 50:  
		velocity.x = speed * axis


func set_y_velocity(vel: float) -> void:
	velocity.y = vel

func get_velocity() -> Vector2:
	return velocity

func is_moving() -> bool:
	if velocity == Vector2.ZERO:
		return false
	else:
		return true

func _physics_process(delta: float) -> void:
	if parent is Slug:
		if slug_state_machine.get_state() == slug_state_machine.get_states().in_air:
			velocity.y += gravity*delta
		else:
			velocity.y = 0.0
	velocity = velocity + knockback_velocity
	knockback_velocity = lerp(knockback_velocity,Vector2.ZERO,0.2)

func knock_back(knockback_direction: Vector2) -> void:
	knockback_velocity = knockback_direction * knockback_force
	knockback_velocity.y = min(knockback_velocity.y, 200) 

func cancel_knock_back() -> void:
	knockback_velocity = Vector2.ZERO
