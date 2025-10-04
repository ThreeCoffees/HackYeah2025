extends Node

var current = "rain"

signal rain_started;
signal rain_stopped;
signal rain_changed(bool);
signal sun_started;
signal sun_stopped;
signal sun_changed(bool);

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
