extends Node2D

var rocket_scene = preload("res://Scenes/projectiles/rocket.tscn")
var terrain_piece_scene = preload("res://Scenes/terrain/terrain_piece.tscn")
var inventory_resource: Inventory = preload("res://Resources/green_inventory.tres")
var inventory_array: Array[Weapon]
@onready var terrain = $Terrain
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_array = inventory_resource.get_inventory()
	for piece in terrain.get_children():
		piece.connect("new_terrain", spawn_new_terrain)
	for slug: Slug in  $Slugs.get_children():
		slug.set_current_weapon(inventory_array[0])
		slug.connect("shoot_projectile", spawn_projectile)
	
func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is  InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed():
			#spawn_rocket(get_global_mouse_position())
			pass

func spawn_rocket(spawn_pos: Vector2) -> void:
	var rocket: Rocket = rocket_scene.instantiate()
	rocket.global_position = spawn_pos
	$Projectiles.add_child(rocket)

func spawn_projectile(projectile: PackedScene, start_position: Vector2, direction: Vector2, shooter: Slug):
	var new_projectile: Node2D = projectile.instantiate()
	new_projectile.global_position = start_position + 10*direction
	new_projectile.set_direction(direction)
	new_projectile.set_shooter(shooter)
	$Projectiles.add_child(new_projectile)

func spawn_new_terrain(visual_poly: Array, _new_position: Vector2, terrain_color: Color) -> void:
	var new_visual_polygon: Polygon2D = Polygon2D.new()
	var new_terrain_piece: TerrainPiece = terrain_piece_scene.instantiate()
	new_visual_polygon.polygon = visual_poly

	new_terrain_piece.connect("new_terrain", spawn_new_terrain)
	#new_terrain_piece.global_position = new_position
	terrain.add_child(new_terrain_piece)
	new_terrain_piece.set_visual_polygon(new_visual_polygon)
	new_terrain_piece.set_color(terrain_color)
