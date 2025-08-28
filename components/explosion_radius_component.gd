extends Area2D
class_name ExplosionRadiusComponent
var explosion_radius: CollisionPolygon2D
var bodies_in_range: Array[Node2D] = []
var shooter: Slug
@export var damage: int = 50
func _ready() -> void:
	explosion_radius = get_node("ExplosionRadius")
	if get_parent() is Slug:
		shooter = get_parent()
	connect("body_entered", _body_entered)
	connect("body_exited", _body_exited)
func _body_entered(body:Node2D) -> void:
	if body is Slug or body is TerrainPiece:
		bodies_in_range.append(body)
func _body_exited(body:Node2D) -> void:
	bodies_in_range.erase(body)

static var explosion_chain_active: bool = false

func explode(self_explosion: bool = false) -> void:
	if explosion_chain_active:
		call_deferred("_delayed_explode", self_explosion)
		return
	
	explosion_chain_active = true
	
	for body in bodies_in_range:
		if body != null and body is Slug:
			if !(self_explosion and shooter == body):
				var direction_to_body: Vector2 = (body.global_position - get_parent().global_position).normalized()
				body.hit(shooter, damage, direction_to_body)
	
	call_deferred("_explode_terrain")
	call_deferred("_reset_explosion_chain")

func _delayed_explode(self_explosion: bool = false) -> void:
	await get_tree().process_frame
	if not explosion_chain_active:
		explode(self_explosion)

func _reset_explosion_chain() -> void:
	explosion_chain_active = false

func _explode_terrain() -> void:
	for body in bodies_in_range:
		if body != null and body is TerrainPiece:
			body.terrain_explosion(explosion_radius)
