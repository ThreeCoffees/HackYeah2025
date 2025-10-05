extends PlayableCharacter;

signal end_level;

func set_as_player():
	super();
	print("you won");
	end_level.emit();
