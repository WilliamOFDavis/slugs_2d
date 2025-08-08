extends Node2D

@export var velocity_component: VelocityComponent
@export var jump_impulse: float = -200.0

func _unhandled_input(event: InputEvent) -> void:
	var x_direction: float = Input.get_axis("move_left", "move_right")
	
	velocity_component.set_x_direction(x_direction)
	
	if Input.is_action_just_pressed("jump") and get_parent().is_on_floor():
		velocity_component.set_y_velocity(jump_impulse)
