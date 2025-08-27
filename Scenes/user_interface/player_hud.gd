extends CanvasLayer

class_name PlayerHud

@onready var slugs_display: HBoxContainer = $MarginContainer/RemainingSlugsDisplay
var team_array: Array[Team]
var current_inventory: Inventory
var inventory_dictionary: Dictionary[Button, Weapon] = {}
# Called when the node enters the scene tree for the first time.
func setup_team_display(teams: Array[Team]) -> void:
	team_array = teams

func draw_team_display() -> void:
	for display_item: TextureRect in slugs_display.get_children():
		display_item.queue_free()
	for team: Team in team_array:
		var team_color: Color = team.team_color
		for slug in team.slugs:
			var slug_shader: ShaderMaterial = ShaderMaterial.new()
			var slug_texture_rect: TextureRect = TextureRect.new()
			slug_shader.shader = load("res://shaders/slug_team_shader.gdshader").duplicate()
			slug_shader.set_shader_parameter("team_color", team.team_color)
			slug_texture_rect.texture = load("res://Graphics/slug.png")
			slug_texture_rect.material = slug_shader
			slugs_display.add_child(slug_texture_rect)

func draw_current_inventory() -> void:
	for button: Button in $MarginContainer/InventoryToolbar.get_children():
		button.queue_free()
	if current_inventory != null:
		for weapon: Weapon in current_inventory.get_inventory():
			pass

func set_inventory(inventory: Inventory) -> void:
	current_inventory = inventory

func draw_hud(active_slug: Slug) -> void:
	pass

func _process(delta: float) -> void:
	draw_team_display()
