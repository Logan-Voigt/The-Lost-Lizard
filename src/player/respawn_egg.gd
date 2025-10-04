class_name RespawnEgg extends CharacterBody2D

const PLAYER_AND_GROUND_LAYER : int  = 3
const JUST_GROUND_LAYER : int = 2

func _physics_process(delta: float) -> void:
	if not GameState.is_in_game(): queue_free()
	if not is_on_floor():
		velocity += get_gravity() * delta
		collision_layer = JUST_GROUND_LAYER
		move_and_slide()
		return
	
	if GameState.player_location.y < global_position.y:
		collision_layer = PLAYER_AND_GROUND_LAYER
	else:
		collision_layer = JUST_GROUND_LAYER
	
	move_and_slide()
