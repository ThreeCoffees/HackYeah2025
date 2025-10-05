extends Control

var main_menu = load("res://levels/main_menu.tscn")

var is_paused = false

func _ready():
	visible = false

		
func _on_end_level():
	toggle_end();

func toggle_end():
	is_paused = !is_paused
	#get_tree().paused = is_paused

	visible = is_paused
	Engine.time_scale = 0
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func restart_game():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func back():
	Engine.time_scale = 1
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var instance = main_menu.instantiate()
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	tree.get_root().add_child(instance)
	tree.get_root().remove_child(cur_scene)
	tree.set_current_scene(instance)
