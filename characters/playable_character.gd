extends CharacterBody3D
class_name PlayableCharacter

signal hover_start
signal hover_end

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
	AudioManager.play("swoosh")
	

func _on_crosshair_hover():
	hover_start.emit()

func _on_crosshair_hover_end():
	hover_end.emit()
