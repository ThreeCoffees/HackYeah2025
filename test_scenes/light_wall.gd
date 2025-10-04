extends Node3D

var noise: Noise
var threshold = -1.1
var target_threshold = -1.1
var time = 0

func _ready() -> void:
	GlobalStateManager.sun_started.connect(_on_sun_started)
	GlobalStateManager.sun_stopped.connect(_on_sun_stopped)
	
	if GlobalStateManager.current == "sun":
		_on_sun_started()
	
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()

func _on_sun_started() -> void:
	target_threshold = 1.1
	$Collider/CollisionShape3D.disabled = false

func _on_sun_stopped() -> void:
	target_threshold = -1.1
	$Collider/CollisionShape3D.disabled = true

func _process(delta: float) -> void:
	threshold = move_toward(threshold, target_threshold, delta*2.5)
	time += delta*500
	$Light.visible = noise.get_noise_1d(time) < threshold
