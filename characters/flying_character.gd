extends PlayableCharacter
class_name FlyingCharacter

const SPEED = 5.0

func _physics_process(delta: float) -> void:
	if is_player():
		input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
		input_vertical = Input.get_axis("move_down", "move_up");
		
		var direction := (transform.basis * Vector3(input_dir.x, input_vertical, input_dir.y)).normalized()
		
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			
		if input_vertical:
			velocity.y = input_vertical * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity += get_gravity() * delta

	move_and_slide()
	
