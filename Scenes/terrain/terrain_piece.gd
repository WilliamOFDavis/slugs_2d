extends StaticBody2D

class_name TerrainPiece

@export var visual_polygon: Polygon2D = Polygon2D.new()
@export var visual_poly_array: Array[Vector2]

var collision_polygon: CollisionPolygon2D = CollisionPolygon2D.new()

signal new_terrain(visual_poly, new_pos, color)

func _ready() -> void:
	call_deferred("setup_collision")

	

func setup_collision() -> void:
	visual_polygon.position = Vector2.ZERO
	collision_polygon.position = Vector2.ZERO
	var collis_poly = []
	for point in visual_polygon.polygon:
		collis_poly.append(visual_polygon.to_global(point))
	collision_polygon.polygon = collis_poly
	add_child(collision_polygon)

func terrain_explosion(explosion_radius: Node2D) -> void:
	var clipped_global = [] #Polygon being clipped
	var clipper_global = [] #Polygon doing clipping
	for point in visual_polygon.polygon:
		clipped_global.append(visual_polygon.to_global(point))
	for point in explosion_radius.polygon:
		clipper_global.append(explosion_radius.to_global(point))
	
	var resultant_polys = Geometry2D.clip_polygons(clipped_global, clipper_global)
	var resultant_poly_local = []
	
	if resultant_polys.size() > 0:
		global_position = Vector2.ZERO
		visual_polygon.set_deferred("polygon", resultant_polys[0])
		collision_polygon.set_deferred("polygon", resultant_polys[0])
	else:
		self.queue_free()
	if resultant_polys.size() > 1:
		for index in range(resultant_polys.size()-1):
			var poly = resultant_polys[index+1]
			var poly_local = []
			for point in poly:
				poly_local.append(point)
			new_terrain.emit(poly_local, Vector2.ZERO, visual_polygon.color)
	#visual_polygon.polygon = resultant_poly_local
func set_visual_polygon(visual_poly: Polygon2D) -> void:
	visual_polygon =  visual_poly
	collision_polygon.polygon = visual_poly.polygon
	call_deferred("add_child", visual_polygon)

func set_color(poly_color: Color) -> void:
	visual_polygon.color = poly_color
