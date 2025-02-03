extends Node3D

# Custom method for setting position
func set_custom_position(pos: Vector3):
	global_transform = Transform3D(global_transform.basis, pos)  # Update the global position <button class="citation-flag" data-index="1">
	print("Position updated to: ", pos)

func is_valid_position() -> bool:
	# Sprawdź, czy pozycja jest na ścieżce przeciwników
	var raycast = RayCast3D.new()
	add_child(raycast)
	raycast.cast_to = Vector3.DOWN * 2  # Sprawdź kolizję z podłożem
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("path"):  # Sprawdź, czy kolider należy do grupy "path"
			return false
	return true
