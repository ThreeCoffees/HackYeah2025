extends CharacterBody3D
class_name PlayableCharacter

@onready var camera_offset = $CameraOffset;

var input_dir:= Vector2();
var input_vertical:=0.0;

func _ready():
	if is_player():
		var camera = get_node_or_null("PlayerCamera");
		camera.position = camera_offset.position;
		visible = false;


func is_player():
	var camera = get_node_or_null("PlayerCamera");
	return is_instance_valid(camera) and not camera.input_locked;

func _on_pick_input(emitter_position):
	set_as_player();
	
func set_as_player():
	var player_camera = PlayerCamera.instance;
	player_camera.transfer_camera(self);
	visible = false;
