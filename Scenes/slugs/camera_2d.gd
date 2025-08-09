extends Camera2D

var is_zooming_out: bool = false

@export var zoomed_scale: Vector2 = Vector2(1.0,1.0)
@export var zoomed_out_scale: Vector2 = Vector2(0.5,0.5)

func toggle_zoom() -> void:
	is_zooming_out = !is_zooming_out

func _physics_process(delta: float) -> void:
	if is_zooming_out:
		zoom = lerp(zoom, zoomed_out_scale, 0.1)
	else:
		zoom = lerp(zoom, zoomed_scale, 0.1)
