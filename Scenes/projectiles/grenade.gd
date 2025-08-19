extends RigidBody2D

class_name Grenade

var force_magnitude: float = 30000.0
var initial_force: Vector2
var shooter: Slug
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	constant_force = initial_force
	$DetonationTimer.start()

func _physics_process(delta: float) -> void:
	constant_force = lerp(constant_force, Vector2.ZERO, 0.5)

func set_shooter(slug:Slug) -> void:
	shooter = slug
	$ExplosionRadiusComponent.shooter = shooter

func set_initial_force(force_direction) -> void:
	initial_force = force_direction * force_magnitude


func _on_detonation_timer_timeout() -> void:
	$ExplosionRadiusComponent.explode()
	self.queue_free()
