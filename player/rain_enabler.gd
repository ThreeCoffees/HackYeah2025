extends Node3D

var target_visibility: float = 0
var current_visibility: float = 0

func _ready() -> void:
	if GlobalStateManager.current == "rain":
		target_visibility = 1
		current_visibility = 1
	
	GlobalStateManager.rain_changed.connect(_on_rain_changed)

func _on_rain_changed(raining: bool) -> void:
	if raining:
		target_visibility = 1
	else:
		target_visibility = 0

func _process(delta: float) -> void:
	global_rotation.y = 0
	global_rotation.x = 0
	global_rotation.z = 0
	current_visibility = move_toward(current_visibility, target_visibility, delta * 0.3)
	
	var under_ceiling = $RayRainCast.is_colliding()
	var visibility_multiplier = 1.0
	if under_ceiling:
		visibility_multiplier = 0.06
	
	for child in get_children():
		if child is MeshInstance3D:
			(((child as MeshInstance3D).mesh as CylinderMesh).material as ShaderMaterial).set_shader_parameter("visibility", current_visibility * visibility_multiplier)
