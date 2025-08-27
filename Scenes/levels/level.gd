extends Node2D

var rocket_scene = preload("res://Scenes/projectiles/rocket.tscn")
var terrain_piece_scene = preload("res://Scenes/terrain/terrain_piece.tscn")
var inventory_resource: Inventory = preload("res://Resources/green_inventory.tres")
var inventory_array: Array[Weapon]
var active_slug: Slug
var active_team_index: int = 0
var teams: Array[Team] = [
	preload("res://Resources/green_team.tres"),
	preload("res://Resources/blue_team.tres")
]
var slug_scene: PackedScene = preload("res://Scenes/slugs/slug.tscn")

@export var slugs_per_team: int = 5
@onready var terrain = $Terrain
@onready var hud: PlayerHud = $PlayerHud
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	teams[0].set_spawn_points($GreenSpawnPoints.get_children())
	teams[1].set_spawn_points($RedSpawnPoints.get_children())
	initialise_teams()
	#inventory_resource.initialise_inventory()
	#inventory_array = inventory_resource.get_inventory()
	for piece in terrain.get_children():
		piece.connect("new_terrain", spawn_new_terrain)
	#for slug: Slug in  $Slugs.get_children():
		#if slug.name == "Slug":
			#slug.begin_turn()
		#slug.set_inventory(inventory_resource)
		#slug.connect("shoot_projectile", spawn_projectile)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("end_turn"):
		end_turn(true)

func initialise_teams() -> void:
	for team in teams:
		team.team_inventory.initialise_inventory()
		for i in range(slugs_per_team):
			var slug: Slug = slug_scene.instantiate()
			slug.position = team.spawn_points[i].position
			slug.set_inventory(team.team_inventory)
			slug.connect("shoot_projectile", spawn_projectile)
			slug.connect("dead", on_slug_death)
			slug.set_team(team)
			team.add_slug(slug)
			$Slugs.add_child(slug)
	hud.setup_team_display(teams)
	active_slug = teams[0].get_next_slug()
	hud.set_active_slug(active_slug)
	active_team_index += 1
	active_slug.begin_turn()


func deactivate_slug() -> void:
	if active_slug != null:
		active_slug.end_turn()

func end_turn(triggered: bool = false) -> void:
	#if !triggered:
	if triggered:
		deactivate_slug()
	$EndTurnTimer.start()
	#else:
		#goto_next_turn()
func goto_next_turn() -> void:
	if active_slug != null:
		active_slug.deactivate_camera()
	active_slug = teams[active_team_index%teams.size()].get_next_slug()
	hud.set_active_slug(active_slug)
	active_slug.begin_turn()
	active_team_index += 1
	$EndTurnTimer.wait_time = 1.0

func spawn_rocket(spawn_pos: Vector2) -> void:
	var rocket: Rocket = rocket_scene.instantiate()
	rocket.global_position = spawn_pos
	$Projectiles.add_child(rocket)

func spawn_projectile(projectile: PackedScene, start_position: Vector2, direction: Vector2, shooter: Slug, multiplier: float = 1.0):
	var new_projectile: Node2D = projectile.instantiate()
	new_projectile.global_position = start_position + 10*direction
	if new_projectile is RigidBody2D:
		new_projectile.set_initial_force(direction, multiplier)
	else:
		new_projectile.set_direction(direction, multiplier)
	new_projectile.set_shooter(shooter)
	new_projectile.connect("explosion", end_turn)
	deactivate_slug()
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

func on_slug_death(slug: Slug) -> void:
	if slug == active_slug:
		goto_next_turn()
	if !$EndTurnTimer.is_stopped():
		$EndTurnTimer.stop()
	slug.current_team.remove_slug(slug)
	
