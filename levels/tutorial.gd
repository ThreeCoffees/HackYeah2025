extends Node3D

func _ready() -> void:
	$"/root/GlobalStateManager".set_property("rain")
