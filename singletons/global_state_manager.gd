extends Node

var rain: bool = false;
var sun: bool = false;
var death: bool = false;

signal rain_started;
signal rain_stopped;
signal rain_changed(bool);
signal sun_started;
signal sun_stopped;
signal sun_changed(bool);
signal death_started;
signal death_stopped;
signal death_changed(bool);

func set_property(property: String, value: bool) -> void:
	if property == "rain":
		set_rain(value)
	elif property == "sun":
		set_sun(value)
	elif property == "death":
		set_death(value)
	else:
		print("WRONG PROPERTY!!! " + property)

func set_rain(new_rain: bool) -> void:
	print("setting rain to " + str(new_rain))
	rain = new_rain;
	rain_changed.emit(rain)
	if rain:
		rain_started.emit()
	else:
		rain_stopped.emit()

func set_sun(new_sun: bool) -> void:
	print("setting sun to " + str(new_sun))
	sun = new_sun;
	sun_changed.emit(sun)
	if sun:
		sun_started.emit()
	else:
		sun_stopped.emit()

func set_death(new_death: bool) -> void:
	print("setting death to " + str(new_death))
	death = new_death;
	death_changed.emit(death)
	if death:
		death_started.emit()
	else:
		death_stopped.emit()
