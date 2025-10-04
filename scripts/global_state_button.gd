extends Node3D

@export_enum("rain", "sun", "death") var property: String = "rain"
@export_enum("enable", "disable") var action: String = "enable"

func _ready() -> void:
	($TempTextMesh.mesh as TextMesh).text = action + "\n" + property

func _on_area_3d_clicked() -> void:
	GlobalStateManager.set_property(property, action == "enable")
