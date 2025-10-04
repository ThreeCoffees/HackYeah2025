extends Camera3D
class_name PlayerCamera;

const mouse_sensitivity = 0.003;

@onready var picking_ray = $PickingRayCast;

static var instance;

var input_locked = false;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	if is_instance_valid(instance):
		print("only one player camera allowed");
	instance = self;

func _unhandled_input(event):
	if input_locked:
		return;
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		get_parent().rotate_y(-event.relative.x * mouse_sensitivity);
		rotate_x(-event.relative.y * mouse_sensitivity);
		rotation.x = clampf(rotation.x, -deg_to_rad(70), deg_to_rad(70));
		
func transfer_camera(new_parent: PlayableCharacter):
	reparent(new_parent, false);
	input_locked = true;
	position = new_parent.camera_offset.position;


func _process(_delta: float):
	if Input.is_action_just_pressed("pick"):
		var picked_object = picking_ray.get_collider();
		if not is_instance_valid(picked_object):
			return
		if picked_object.has_method("_on_pick_input"):
			picked_object._on_pick_input();
