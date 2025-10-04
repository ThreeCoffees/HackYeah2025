extends CharacterBody3D
class_name PlayableCharacter

@onready var camera_offset = $CameraOffset;

func is_player():
	return is_instance_valid(get_node_or_null("PlayerCamera"));

func _on_pick_input():
	set_as_player();
	
func set_as_player():
	var player_camera = PlayerCamera.instance;
	player_camera.reparent(self, false);
	player_camera.position = camera_offset.position;
