extends Node3D

@export_enum("rain", "sun") var property: String = "rain"

func _ready() -> void:
	$TempTextMesh.mesh = $TempTextMesh.mesh.duplicate()
	($TempTextMesh.mesh as TextMesh).text = property

func _on_area_3d_clicked() -> void:
	GlobalStateManager.set_property(property)
