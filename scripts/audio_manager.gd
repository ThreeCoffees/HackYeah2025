extends Node
## A singleton. Scans child `AudioStreamPlayers` to play later.

## All available sounds
var players: Dictionary

## Scan and register sounds to play
func _enter_tree():
	for c in get_children():
		players.set(c.name, c)

## Play a sound without changing any paramters
func play(sound: String):
	if players.has(sound):
		players.get(sound).play()

## Play a sound with a given volume <0dB
func play_with_volume(sound: String, db: float):
	if players.has(sound):
		players.get(sound).volume_db = min(0, db)
		players.get(sound).play()

## Stop a currently playing sound
func stop(sound: String):
	if players.has(sound):
		players.get(sound).stop()
