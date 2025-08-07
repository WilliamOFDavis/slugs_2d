extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var poly1_global = []
	#var poly2_global = []
	#
	#for point in $Polygon2D.polygon: 
		#print(point)
		#poly1_global.append($Polygon2D.to_global(point))
	#for point in $Polygon2D2.polygon: 
		#print(point)
		#poly2_global.append($Polygon2D2.to_global(point))
	#var geo =  Geometry2D.clip_polygons(poly1_global, poly2_global)
	#var clipped_local = []
	##for polygon in geo:
		##var local_polygon = []
		##for point in polygon:
			##local_polygon.append($Polygon2D4.to_local(point))
		##clipped_local.append(local_polygon)
	#$Polygon2D.visible = false
	#$Polygon2D2.visible = false
	#if geo.size() > 0:
		#$Polygon2D4.polygon = geo[0]
	#if geo.size() > 1:
		#$Polygon2D5.polygon = geo[1]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
