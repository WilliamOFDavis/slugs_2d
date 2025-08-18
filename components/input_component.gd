extends Node2D

@export var velocity_component: VelocityComponent
@export var jump_impulse: float = -300.0
@export var sprite: AnimatedSprite2D 
@export var weapon_sprite: Sprite2D
@export var camera: Camera2D

signal shoot_weapon(direction)
signal switch_weapon

func _unhandled_input(event: InputEvent) -> void:
	if get_parent().active_turn:
		var x_direction: float = Input.get_axis("move_left", "move_right")
		
		weapon_sprite.look_at(get_global_mouse_position())
		velocity_component.set_x_direction(x_direction)
		
		if Input.is_action_just_pressed("right_mouse"):
			camera.toggle_zoom()
		
		if Input.is_action_just_pressed("jump") and get_parent().is_on_floor():
			sprite.play("in_air")
			velocity_component.set_y_velocity(jump_impulse)
		
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and get_parent().is_on_floor():
			var direction_to_mouse: Vector2 = (get_global_mouse_position() - get_parent().global_position).normalized()
			shoot_weapon.emit(direction_to_mouse)
			get_viewport().set_input_as_handled()
			return

		
		if Input.is_action_just_pressed("switch_weapon"):
			switch_weapon.emit()
	else:
		velocity_component.set_x_direction(0.0)
