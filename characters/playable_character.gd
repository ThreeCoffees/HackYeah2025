extends CharacterBody3D
class_name PlayableCharacter

@onready var camera_offset = $CameraOffset;

func is_player():
	var camera = get_node_or_null("PlayerCamera");
	return is_instance_valid(camera) and not camera.input_locked;

func _on_pick_input(emitter_position):
	set_as_player();
	
func set_as_player():
	var player_camera = PlayerCamera.instance;
	player_camera.transfer_camera(self);
