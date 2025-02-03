extends Node3D

var placing_tower = false
var selected_tower = ""  # Nazwa wybranej wieży (np. "Charmander", "Squirtle")
var placement_indicator = preload("res://Scenes/PlacementIndicator.tscn").instance()
var money = 100  # Waluta gracza
var tower_cost = 50  # Koszt postawienia wieży

func _ready():
	add_child(placement_indicator)
	placement_indicator.visible = false

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:  # Poprawione na MOUSE_BUTTON_LEFT
		if placing_tower:
			var pos = get_mouse_position_in_3d()
			if placement_indicator.is_valid_position():
				if money >= tower_cost:
					place_tower(pos)
					money -= tower_cost
					print("Pozostałe pieniądze: ", money)
				else:
					print("Brak wystarczającej ilości pieniędzy!")
			else:
				print("Nie można postawić wieży w tym miejscu!")
		else:
			start_placing_tower()

func get_mouse_position_in_3d() -> Vector3:
	var camera = $Camera3D
	var from = camera.project_ray_origin(get_viewport().get_mouse_position())
	var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 100
	var space_state = get_world_3d().direct_space_state

	# Utwórz obiekt PhysicsRayQueryParameters3D
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = 0x7FFFFFFF  # Domyślna maska kolizji

	# Wywołaj intersect_ray z obiektem PhysicsRayQueryParameters3D
	var result = space_state.intersect_ray(query)  # Poprawione wywołanie <button class="citation-flag" data-index="1">
	if result:
		return result.position
	return Vector3.ZERO

func start_placing_tower():
	placing_tower = true
	placement_indicator.visible = true

func place_tower(pos: Vector3):
	var tower_scene = null
	if selected_tower == "Charmander":
		tower_scene = preload("res://Scenes/Charmander.tscn")
	elif selected_tower == "Squirtle":
		tower_scene = preload("res://Scenes/Squirtle.tscn")
	elif selected_tower == "Bulbasaur":
		tower_scene = preload("res://Scenes/Bulbasaur.tscn")

	if tower_scene:
		var tower = tower_scene.instance()
		tower.global_transform.origin = pos
		$Towers.add_child(tower)

	placing_tower = false
	placement_indicator.visible = false

# Funkcja wywoływana, gdy gracz wybiera wieżę
func select_tower(tower_name: String):
	selected_tower = tower_name
	start_placing_tower()
