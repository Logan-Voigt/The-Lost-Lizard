extends Node2D

var just_completed_tutorial : bool

func level_complete() -> void:
	if GameState.current_level + 1 < GameState.completed_levels.size():
		GameState.completed_levels[GameState.current_level + 1] = true
	
	if GameState.current_level == 7:
		GameState.setup_wait_state(start_cave_levels)
		EventBus.clear_player.emit()
		just_completed_tutorial = true
	else:
		EventBus.start_level.emit(GameState.current_level + 1)

func start_cave_levels() -> void:
	EventBus.start_level.emit(GameState.current_level + 1)


func _on_egg_zone_body_entered(body: Node2D) -> void:
	if body is RespawnEgg:
		body.queue_free()
		call_deferred("level_complete")


func _input(event: InputEvent) -> void:
	if just_completed_tutorial and event.is_action_pressed("set_egg"):
		just_completed_tutorial = false
		GameState.exit_wait_state()
