extends Area3D

signal clicked

func _on_pick_input():
	clicked.emit()
