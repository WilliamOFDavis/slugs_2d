extends Area2D

class_name ExplosionRadiusComponent

var explosion_radius: CollisionPolygon2D
var bodies_in_range: Array[Node2D] = []
var shooter: Slug
@export var damage: int = 50


func _ready() -> void:
	explosion_radius = get_node("ExplosionRadius")
	connect("body_entered", _body_entered)
	connect("body_exited", _body_exited)

func _body_entered(body:Node2D) -> void:
	if body != shooter:
		if body is Slug or body is TerrainPiece:
			bodies_in_range.append(body)

func _body_exited(body:Node2D) -> void:
	if body != shooter:
		bodies_in_range.erase(body)
	if body is Slug:
		pass
func explode() -> void:
	for body in bodies_in_range:
		if body != null:
			if body is TerrainPiece:
				body.terrain_explosion(explosion_radius)
			elif body is Slug:
				var direction_to_body: Vector2 = ( body.global_position -  get_parent().global_position).normalized()
				body.hit(shooter, damage, direction_to_body)
