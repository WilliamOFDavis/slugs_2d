extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func terrain_explosion(explosion_radius: Polygon2D) -> void:
	var visual_polygon: Polygon2D = $VisualPoly
	var clipped_global = [] #Polygon being clipped
	var clipper_global = [] #Polygon doing clipping
	for point in visual_polygon.polygon:
		clipped_global.append(visual_polygon.to_global(point))
	for point in explosion_radius.polygon:
		clipper_global.append(explosion_radius.to_global(point))
	
	var resultant_polys = Geometry2D.clip_polygons(clipped_global, clipper_global)
	var resultant_poly_local = []
	
	for point in resultant_polys[0]:
		resultant_poly_local.append(visual_polygon.to_local(point))
	
	#visual_polygon.polygon = resultant_poly_local
	visual_polygon.set_deferred("polygon", resultant_poly_local)
	$CollisionPoly.set_deferred("polygon", resultant_poly_local)
