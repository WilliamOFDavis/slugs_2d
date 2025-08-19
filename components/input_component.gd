extends Node2D

@export var velocity_component: VelocityComponent
@export var jump_impulse: float = -300.0
@export var sprite: AnimatedSprite2D 
@export var weapon_sprite: Sprite2D
@export var camera: Camera2D
@export var max_multiplier: float = 10.0
@export var mult_label: Label
@export var charge_per_second: float = 1.0

var input_multiplier: float = 1.0
var is_charging: bool = false

signal shoot_weapon(direction, multiplier)
signal switch_weapon

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("right_mouse"):
			camera.toggle_zoom()
	if get_parent().active_turn:
		var x_direction: float = Input.get_axis("move_left", "move_right")
		
		weapon_sprite.look_at(get_global_mouse_position())
		velocity_component.set_x_direction(x_direction)
		
		
		
		if Input.is_action_just_pressed("jump") and get_parent().is_on_floor():
			sprite.play("in_air")
			velocity_component.set_y_velocity(jump_impulse)
		
		#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and get_parent().is_on_floor():
			#var direction_to_mouse: Vector2 = (get_global_mouse_position() - get_parent().global_position).normalized()
			#shoot_weapon.emit(direction_to_mouse, 1.0)
			#get_viewport().set_input_as_handled()
			#return
		#
		#if Input.is_action_just_pressed("left_mouse") and get_parent().is_on_floor():
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and get_parent().is_on_floor() and is_charging == false:
			is_charging = true
			return
		
		
		
		#if Input.is_action_just_released("left_mouse"):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released() and get_parent().is_on_floor() and is_charging:
			var direction_to_mouse: Vector2 = (get_global_mouse_position() - get_parent().global_position).normalized()
			is_charging = false
			shoot_weapon.emit(direction_to_mouse, input_multiplier)
			input_multiplier = 1.0
			return
		
		if Input.is_action_just_pressed("switch_weapon"):
			switch_weapon.emit()
	else:
		velocity_component.set_x_direction(0.0)

func _physics_process(delta: float) -> void:
	if is_charging and input_multiplier < max_multiplier: 
		input_multiplier += charge_per_second * delta
	if !get_parent().is_on_floor() and is_charging:
			is_charging = false
			input_multiplier = 1.0
	mult_label.text = str(snapped(input_multiplier, 0.1))
