extends CanvasLayer

class_name PlayerHud

@onready var slugs_display: HBoxContainer = $MarginContainer/VBoxContainer/RemainingSlugsDisplay
var team_array: Array[Team]
var active_slug: Slug
var current_inventory: Inventory
var inventory_dictionary: Dictionary[Button, Weapon] = {}
const button_theme: Theme = preload("res://Resources/Theme/inventory_button_theme.tres")
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
	if active_slug != null:
		if active_slug.current_weapon != null:
			$MarginContainer/VBoxContainer/HSplitContainer/AmmoTexture.texture = active_slug.current_weapon.weapon_texture
			$MarginContainer/VBoxContainer/HSplitContainer/AmmoTexture/AmmoLabel.text = str(active_slug.current_weapon.current_ammo)

func draw_current_inventory() -> void:
	for button: Button in $MarginContainer/InventoryToolbar.get_children():
		button.queue_free()
	if current_inventory != null:
		var new_inventory_dictionary: Dictionary[Button, Weapon] = {}
		for weapon: Weapon in current_inventory.get_inventory():
			var new_button: Button = Button.new()
			new_button.connect("pressed", on_button_press.bind(new_button))
			new_button.icon = weapon.weapon_texture
			new_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			new_button.expand_icon = true
			new_button.custom_minimum_size = Vector2(64,64)
			new_button.theme = button_theme
			new_inventory_dictionary[new_button] = weapon
			$MarginContainer/InventoryToolbar.add_child(new_button)
		inventory_dictionary = new_inventory_dictionary.duplicate()

func set_inventory(inventory: Inventory) -> void:
	current_inventory = inventory
	draw_current_inventory()

func set_active_slug(slug: Slug) -> void:
	active_slug = slug
	set_inventory(slug.current_inventory)

func draw_hud(active_slug: Slug) -> void:
	pass

func _process(delta: float) -> void:
	draw_team_display()


func on_button_press(button: Button) -> void:
	var selected_weapon: Weapon = inventory_dictionary[button]
	active_slug.set_current_weapon(selected_weapon)
