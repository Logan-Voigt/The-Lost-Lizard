extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if not GameState.is_in_game(): queue_free()
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
