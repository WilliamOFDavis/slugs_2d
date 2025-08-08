extends CharacterBody2D

class_name Slug

var jumping = false
var gravity: float = 50.0
var is_zooming_out: bool = false
@onready var velocity_component: VelocityComponent = $VelocityComponent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func hit():
	global_position = Vector2(0,-100)

func _physics_process(_delta: float) -> void:
	##$AnimatedSprite2D/RocketLauncher.look_at(get_global_mouse_position())
	#if is_zooming_out:
		#$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(0.4,0.4), 0.2)
	#else:
		#$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(1,1), 0.2)
	#var x_direction: float = Input.get_axis("move_left","move_right")
	#velocity.x = 200 * x_direction
	#if x_direction == -1:
		##$AnimatedSprite2D/RocketLauncher.flip_v = true
		#$AnimatedSprite2D.flip_h = true
	#elif x_direction == 1:
		##$AnimatedSprite2D/RocketLauncher.flip_v= false
		#$AnimatedSprite2D.flip_h = false
	#if !is_on_floor():
		#velocity.y += gravity
	#if is_on_floor() and jumping:
		#jumping = false
		#$AnimatedSprite2D.play("walk")
	#if Input.is_action_just_pressed("right_mouse"):
		#if is_zooming_out:
			#is_zooming_out = false
		#else:
			#is_zooming_out = true
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#$AnimatedSprite2D.play("in_air")
		#jumping = true
		#velocity.y = -1000.0
	velocity = velocity_component.get_velocity()
	move_and_slide()
