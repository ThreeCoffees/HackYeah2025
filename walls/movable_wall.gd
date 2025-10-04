extends Node3D

@export var actual_wall: Node3D
@export var active_position: Node3D
@export var passive_position: Node3D
@export var move_speed: float = 10
@export_enum("step", "linear", "smoothstep") var interp_type: String = "smoothstep"

@export var is_active: bool = false
var t: float = 0

func _ready() -> void:
	if is_active:
		t = 1
		actual_wall.global_position = active_position.global_position
	else:
		t = 0
		actual_wall.global_position = passive_position.global_position

func calc_smoothed_t() -> float:
	if interp_type == "step":
		if is_active:
			return 1
		else:
			return 0
	elif interp_type == "linear":
		return t
	else:
		return 3*t*t - 2*t*t*t

func _physics_process(delta: float) -> void:
	var distance = (active_position.global_position - passive_position.global_position).length()
	var time_to_sweep = distance / move_speed
	
	if is_active:
		t += delta / time_to_sweep
	else:
		t -= delta / time_to_sweep
	
	t = clamp(t, 0, 1)
	
	var smooth_t = calc_smoothed_t()
	
	actual_wall.transform = passive_position.transform.interpolate_with(active_position.transform, smooth_t)


func set_active_val(new_acitve: bool) -> void:
	is_active = new_acitve
	
func toggle_active() -> void:
	is_active = not is_active
	
func toggle_active_dummy_arg(_ignored_arg) -> void:
	is_active = not is_active
	
func toggle_active_if_player(body: Node3D) -> void:
	if body is WalkingCharacter:
		is_active = not is_active
	
func set_active() -> void:
	is_active = true
	
func set_active_if_player(body: Node3D) -> void:
	if body is WalkingCharacter:
		is_active = true

func set_inactive() -> void:
	is_active = false
	
func set_inactive_if_player(body: Node3D) -> void:
	if body is WalkingCharacter:
		is_active = false
