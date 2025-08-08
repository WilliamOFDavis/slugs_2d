extends CharacterBody2D

var jumping = false
var gravity: float = 50.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	var x_direction: float = Input.get_axis("move_left","move_right")
	velocity.x = 200 * x_direction
	if x_direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif x_direction == 1:
		$AnimatedSprite2D.flip_h = false
	if !is_on_floor():
		velocity.y += gravity
	if is_on_floor() and jumping:
		jumping = false
		$AnimatedSprite2D.play("walk")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		jumping = true
		velocity.y = -1000.0
	
	move_and_slide()
