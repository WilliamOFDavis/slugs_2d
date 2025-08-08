extends StateMachine

@export var sprite: AnimatedSprite2D 
@export var velocity_component: VelocityComponent
@onready var parent: Slug = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_state("walk")
	add_state("idle")
	add_state("in_air")
	call_deferred("set_state", states.idle)
	
func _state_logic(delta) -> void:
	pass

func _get_transition(delta):
	if !parent.is_on_floor() and state != states.in_air:
		set_state(states.in_air)
	
	elif parent.is_on_floor():
		if velocity_component.is_moving():
			if state != states.walk:
				return states.walk
		else:
			if state != states.idle:
				return states.idle

func _enter_state(new_state, old_state) -> void:
	match new_state:
		states.in_air:
			sprite.play("in_air")
		states.walk:
			sprite.play("walk")
		states.idle:
			sprite.play("idle")
func _exit_state(old_state, new_state) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
