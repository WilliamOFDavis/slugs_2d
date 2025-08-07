extends Node2D

class_name Rocket

var velocity: Vector2 = Vector2(0,300)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotate(PI/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("destructible"):
		body.terrain_explosion($ExplosionRadius)
		self.queue_free()
