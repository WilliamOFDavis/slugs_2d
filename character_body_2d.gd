extends CharacterBody2D

var gravity: float = 50.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	var x_direction: float = Input.get_axis("move_left","move_right")
	velocity.x = 200 * x_direction
	if !is_on_floor():
		velocity.y += gravity
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -1000.0
	move_and_slide()
