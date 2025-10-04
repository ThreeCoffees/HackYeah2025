extends Node3D

signal pressed

func retrigger_pressed():
	pressed.emit()

func _on_pick_input():
	AudioManager.play("flick")
	pressed.emit()

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		AudioManager.play("flick")
		pressed.emit()
