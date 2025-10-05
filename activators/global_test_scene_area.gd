extends Area3D

signal clicked
const minimum_distance = 1.5;


func _on_pick_input(emitter_position):
	if position.distance_to(emitter_position) > minimum_distance:
		return;
	clicked.emit()
