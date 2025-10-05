extends RichTextLabel

@export var level_scene: PackedScene

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	gui_input.connect(_on_gui_input)

func _on_mouse_entered() -> void:
	add_theme_color_override("default_color", Color.from_hsv(0, 0, 0.6))

func _on_mouse_exited() -> void:
	add_theme_color_override("default_color", Color.from_hsv(0, 0, 1))

func _on_gui_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	
	var mouse_event: InputEventMouseButton = event
	if mouse_event.button_index == 1 and mouse_event.button_mask == 0:
		if level_scene == null: return
		var instance = level_scene.instantiate()
		var tree = get_tree()
		var cur_scene = tree.get_current_scene()
		tree.get_root().add_child(instance)
		tree.get_root().remove_child(cur_scene)
		tree.set_current_scene(instance)
