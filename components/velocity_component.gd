extends Node2D

class_name VelocityComponent

@onready var parent = get_parent()

@export var slug_state_machine: StateMachine
@export var sprite: Node2D
@export var speed: float = 200.0
@export var gravity: float = 300.0
@export var velocity: Vector2
@export var direction: Vector2 = Vector2.ZERO

var knockback_target: Vector2
var knockback_force: float = 2000.0  
var knockback_velocity: Vector2
var knockback_decay: float = 0.3

func set_x_direction(axis: float) -> void:
	direction.x = axis
	if direction.x == 1:
		sprite.flip_h = false
	elif direction.x == -1:
		sprite.flip_h = true
	
	if knockback_velocity.length() < 20:  
		velocity.x = speed * axis

func set_y_velocity(vel: float) -> void:
	velocity.y = vel

func get_velocity() -> Vector2:
	return velocity

func is_moving() -> bool:
	return velocity != Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Handle gravity
	if parent is Slug:
		if slug_state_machine.get_state() == slug_state_machine.get_states().in_air:
			velocity.y += gravity * delta
		else:
			velocity.y = 0.0
	
	if knockback_velocity.length() > 50:  
		velocity = knockback_velocity
	
	knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, knockback_decay)
	
	#if velocity.x > 0:
		#print("Velocity: ", velocity, " Knockback: ", knockback_velocity)
	if direction.x == 0.0:
		velocity.x = lerp(velocity.x, 0.0, 0.1)

func knock_back(knockback_direction: Vector2) -> void:
	if knockback_direction.length() > 0:
		knockback_direction = knockback_direction.normalized()
	#knockback_direction.y = min(knockback_direction.y, -0.3)
	knockback_velocity = knockback_direction * knockback_force
	
func cancel_knock_back() -> void:
	knockback_velocity = Vector2.ZERO
