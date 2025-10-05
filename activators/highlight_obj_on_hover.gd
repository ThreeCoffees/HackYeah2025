extends MeshInstance3D

func start_highlight():
	if get_surface_override_material_count() >= 1:
		var mat: StandardMaterial3D = get_surface_override_material(0)
		mat.albedo_color = Color.from_hsv(0, 0, 2)

func end_highlight():
	if get_surface_override_material_count() >= 1:
		var mat: StandardMaterial3D = get_surface_override_material(0)
		mat.albedo_color = Color.from_hsv(0, 0, 1)
