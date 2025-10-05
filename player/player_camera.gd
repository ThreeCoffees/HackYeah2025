extends Camera3D
class_name PlayerCamera;

@export var transition_time = 0.3;
var target_transform;
var start_transform;

const mouse_sensitivity = 0.003;
@onready var picking_ray = $PickingRayCast;
var input_locked = false;
var t:float = 0;

var hovering_over: Node = null

static var instance;

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
		rotation.x = clampf(rotation.x, -deg_to_rad(85), deg_to_rad(85));
		
func transfer_camera(new_parent: PlayableCharacter):
	var parent = get_parent();
	parent.input_dir = Vector2();
	parent.input_vertical = 0.0;
	parent.velocity = Vector3();
	parent.visible = true;
	
	reparent(new_parent, true);
	input_locked = true;
	
	start_transform = transform;
	target_transform = new_parent.camera_offset.transform;

func _process(_delta: float):
	
	var new_hover = picking_ray.get_collider();
	if new_hover != hovering_over:
		if new_hover != null and new_hover.has_method("_on_crosshair_hover"):
			new_hover._on_crosshair_hover();
		if hovering_over != null and hovering_over.has_method("_on_crosshair_hover_end"):
			hovering_over._on_crosshair_hover_end();
		hovering_over = new_hover
	
	if input_locked:
		t+= _delta;
		
		var weight = clampf(t / transition_time, 0, 1);
		
		transform = start_transform.interpolate_with(target_transform, weight);
		if t >= transition_time:
			transform = target_transform;
			input_locked = false;
			t = 0;
		return
	if Input.is_action_just_pressed("pick"):
		var picked_object = picking_ray.get_collider();
		if not is_instance_valid(picked_object):
			return
		if picked_object.has_method("_on_pick_input"):
			picked_object._on_pick_input(global_position);
