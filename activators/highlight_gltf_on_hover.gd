extends Node3D

func start_highlight():
	for child in get_children(true):
		if child is MeshInstance3D:
			var mesh = child
			if mesh.mesh.get_surface_count() > 0 and mesh.mesh.surface_get_material(0) is StandardMaterial3D:
				var material: StandardMaterial3D = mesh.mesh.surface_get_material(0)
				material.albedo_color = Color.from_hsv(0, 0, 2)
				

func end_highlight():
	for child in get_children(true):
		if child is MeshInstance3D:
			var mesh = child
			if mesh.mesh.get_surface_count() > 0 and mesh.mesh.surface_get_material(0) is StandardMaterial3D:
				var material: StandardMaterial3D = mesh.mesh.surface_get_material(0)
				material.albedo_color = Color.from_hsv(0, 0, 1)
