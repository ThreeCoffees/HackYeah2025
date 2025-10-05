extends Node3D

signal pressed

const MIN_WAIT = 1000
var last_clicked: float = 0;
const minimum_distance = 1.5;

func retrigger_pressed():
	pressed.emit()

func _on_pick_input(emitter_position):
	if position.distance_to(emitter_position) > minimum_distance:
		return;
	if Time.get_ticks_msec() - last_clicked > MIN_WAIT:
		last_clicked = Time.get_ticks_msec()
		AudioManager.play("flick")
		pressed.emit()

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		_on_pick_input(position)
