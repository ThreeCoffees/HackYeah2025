extends Camera3D

const mouse_sensitivity = 0.003;

signal picking_ray_cast;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		get_parent().rotate_y(-event.relative.x * mouse_sensitivity);
		rotate_x(-event.relative.y * mouse_sensitivity);
		rotation.x = clampf(rotation.x, -deg_to_rad(70), deg_to_rad(70));
	if event is InputEventMouseButton and event.is_action_pressed("pick"):
		picking_ray_cast.emit();
