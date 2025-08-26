extends RegularProjectile

class_name Rocket
#
#@onready var explosion_component: ExplosionRadiusComponent = $ExplosionRadiusComponent
#@export var speed: float = 120.0
#var direction: Vector2 = Vector2.ZERO
#var velocity: Vector2
#var shooter: Slug
#var gravity: float = 100.0
#var force_multiplier: float = 1.0
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#rotate(PI/2)
	#explosion_component.shooter = shooter
#
#func _physics_process(delta: float) -> void:
	#velocity.y += gravity * delta
	#position += velocity * delta
#
#func set_shooter(slug:Slug) -> void:
	#shooter = slug
	#
#func set_direction(new_direction: Vector2, multiplier: float) -> void:
	#direction = new_direction
	#velocity = direction * speed * multiplier
#
#
#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body != shooter:
		#explosion_component.explode()
		#self.queue_free()
