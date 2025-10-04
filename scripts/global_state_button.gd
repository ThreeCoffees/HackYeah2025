extends Node3D

@export_enum("rain", "sun", "death") var property: String = "rain"
@export_enum("enable", "disable") var action: String = "enable"

func _ready() -> void:
	var text = action + "\n" + property
	print("setting text: " + text)
	$TempTextMesh.mesh = $TempTextMesh.mesh.duplicate()
	($TempTextMesh.mesh as TextMesh).text = text

func _on_area_3d_clicked() -> void:
	GlobalStateManager.set_property(property, action == "enable")
