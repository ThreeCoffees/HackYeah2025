extends Node3D

@export_enum("rain", "sun") var property: String = "rain"
@export var button_face_rain: Texture2D
@export var button_face_sun: Texture2D

var t = 0

func _ready() -> void:
	if property == "sun":
		($ButtonFace.get_surface_override_material(0) as StandardMaterial3D).albedo_texture = button_face_sun
	else:
		($ButtonFace.get_surface_override_material(0) as StandardMaterial3D).albedo_texture = button_face_rain

func _process(delta: float) -> void:
	var active: bool = GlobalStateManager.current == property
	
	if active:
		t = move_toward(t, 1, delta * 1.5)
	else:
		t = move_toward(t, 0, delta * 1.5)
	
	$ButtonFace.position = (3*t*t - 2*t*t*t) * Vector3(0.04, -0.04, 0)

func _on_area_3d_clicked() -> void:
	if GlobalStateManager.current != property:
		AudioManager.play("flick")
	GlobalStateManager.set_property(property)
