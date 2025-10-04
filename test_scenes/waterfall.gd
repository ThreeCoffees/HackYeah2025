extends Node3D

const GRAVITY: float = 1000
@export var natural_mesh_height: float = 30

var top: float = 1
var top_speed: float = 0
var bottom: float = 1
var bottom_speed: float = 0

var top_falling: bool = false;
var bottom_falling: bool = false;

func _ready() -> void:
	GlobalStateManager.rain_started.connect(_on_rain_started)
	GlobalStateManager.rain_stopped.connect(_on_rain_stopped)

func _on_rain_started() -> void:
	bottom = 1
	top = 1
	top_falling = false
	bottom_falling = true
	bottom_speed = 0
	top_speed = 0

func _on_rain_stopped() -> void:
	top = 1
	top_falling = true
	top_speed = 0

func position_mesh() -> void:
	var new_scale = top-bottom
	
	if new_scale > 0:
		$WaterfallMeshBase.visible = true
		var new_base_pos = bottom * natural_mesh_height
		
		$WaterfallMeshBase.position.y = new_base_pos
		$WaterfallMeshBase.scale.y = new_scale
	else:
		$WaterfallMeshBase.visible = false

func gravitate(dt: float) -> void:
	if bottom_falling:
		bottom_speed += GRAVITY * dt / natural_mesh_height
		bottom -= bottom_speed * dt / natural_mesh_height
	if top_falling:
		top_speed += GRAVITY * dt / natural_mesh_height
		top -= top_speed * dt / natural_mesh_height
	
	bottom = clamp(bottom, 0, 1)
	top = clamp(top, 0, 1)

func enable_disable_collisions() -> void:
	if top > 0.5 and bottom < 0.5:
		$Collider/CollisionShape3D.set_deferred("disabled", false)
	else:
		$Collider/CollisionShape3D.set_deferred("disabled", true)

func _process(delta: float) -> void:
	gravitate(delta)
	position_mesh()
	enable_disable_collisions()
