extends Node3D

signal pressed

const MIN_WAIT = 1000
var last_clicked: float = 0;

func retrigger_pressed():
	pressed.emit()

func _on_pick_input():
	if Time.get_ticks_msec() - last_clicked > MIN_WAIT:
		last_clicked = Time.get_ticks_msec()
		AudioManager.play("flick")
		pressed.emit()

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		_on_pick_input()
