extends Node

var current = "sun"

signal rain_started;
signal rain_stopped;
signal rain_changed(bool);
signal sun_started;
signal sun_stopped;
signal sun_changed(bool);

const CHANGE_SPEED = 0.2

@export_subgroup("Sun")
@export var sky_color_sun: Color
@export var volumetric_density_sun: float
@export var volumetric_anisotropy_sun: float

@export_subgroup("Rain")
@export var sky_color_rain: Color
@export var volumetric_density_rain: float
@export var volumetric_anisotropy_rain: float

var target_sky_color: Color
var target_volumetric_density: float
var target_volumetric_anisotropy: float

var current_sky_r: float;
var current_sky_g: float;
var current_sky_b: float;
var current_volumetric_density: float;
var current_volumetric_anisotropy: float;

@onready var sun:= $DirectionalLight3D;

func _ready() -> void:
	if current == "sun":
		_on_sun_started()
	if current == "rain":
		_on_rain_started()
	
	current_sky_r = float(target_sky_color.r)
	current_sky_g = float(target_sky_color.g)
	current_sky_b = float(target_sky_color.b)
	current_volumetric_density = float(target_volumetric_density)
	current_volumetric_anisotropy = float(target_volumetric_anisotropy)
	
	GlobalStateManager.rain_started.connect(_on_rain_started)
	GlobalStateManager.sun_started.connect(_on_sun_started)

func _on_rain_started() -> void:
	target_sky_color = sky_color_rain
	target_volumetric_density = volumetric_density_rain
	target_volumetric_anisotropy = volumetric_anisotropy_rain
	AudioManager.stop("ambient_sun")
	AudioManager.play("ambient_rain")

func _on_sun_started() -> void:
	target_sky_color = sky_color_sun
	target_volumetric_density = volumetric_density_sun
	target_volumetric_anisotropy = volumetric_anisotropy_sun
	AudioManager.stop("ambient_rain")
	AudioManager.play("ambient_sun")

func _process(delta: float) -> void:
	current_sky_r = move_toward(float(current_sky_r), float(target_sky_color.r), delta * CHANGE_SPEED)
	current_sky_g = move_toward(float(current_sky_g), float(target_sky_color.g), delta * CHANGE_SPEED)
	current_sky_b = move_toward(float(current_sky_b), float(target_sky_color.b), delta * CHANGE_SPEED)
	current_volumetric_density = move_toward(current_volumetric_density, target_volumetric_density, delta * CHANGE_SPEED)
	current_volumetric_anisotropy = move_toward(current_volumetric_anisotropy, target_volumetric_anisotropy, delta * CHANGE_SPEED)
	
	var sky_col = Color8(int(current_sky_r*255), int(current_sky_g*255), int(current_sky_b*255))
	
	var env: Environment = $WorldEnvironment.environment
	env.background_color = sky_col
	env.volumetric_fog_albedo = sky_col
	env.volumetric_fog_density = current_volumetric_density
	env.volumetric_fog_anisotropy = current_volumetric_anisotropy
	sun.light_color = sky_col

func set_property(property: String) -> void:
	if not ["rain", "sun"].has(property):
		print("WRONG PROPERTY: " + property)
		return
	
	if property == current:
		return
	
	current = property
	
	if property == "sun":
		sun_changed.emit(true)
		sun_started.emit()
		rain_changed.emit(false)
		rain_stopped.emit()
	elif property == "rain":
		rain_changed.emit(true)
		rain_started.emit()
		sun_changed.emit(false)
		sun_stopped.emit()
