extends Resource

class_name Team

@export var team_name: String
@export var team_color: Color
@export var team_inventory: Inventory
var spawn_points: Array[Node]
var slugs: Array[Slug]
var slug_index: int = 0

func set_spawn_points(points: Array[Node]) -> void:
	spawn_points = points

func add_slug(slug: Slug) -> void:
	slugs.append(slug)

func remove_slug(slug: Slug) -> void:
	slugs.erase(slug)
	slug.explode()
	slug_index -= 1

func get_remaining_slug_count() -> int:
	return slugs.size()

func get_next_slug() -> Slug:
	var next_slug: Slug = slugs[slug_index%slugs.size()]
	slug_index += 1
	return next_slug
