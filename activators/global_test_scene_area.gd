extends Area3D

signal clicked
signal hover_start
signal hover_end
const minimum_distance = 1.5;


func _on_pick_input(emitter_position):
	if global_position.distance_to(emitter_position) > minimum_distance:
		return;
	clicked.emit()

func _on_crosshair_hover():
	hover_start.emit()

func _on_crosshair_hover_end():
	hover_end.emit()
