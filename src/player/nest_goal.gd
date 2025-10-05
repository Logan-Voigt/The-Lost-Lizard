extends Node2D

func level_complete() -> void:
	GameState.completed_levels[GameState.current_level] = true
	EventBus.start_level.emit(GameState.current_level + 1)


func _on_egg_zone_body_entered(body: Node2D) -> void:
	if body is RespawnEgg:
		body.queue_free()
		call_deferred("level_complete")
