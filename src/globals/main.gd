extends Node2D

var current_level : Node2D

func _on_delete_level() -> void:
	if current_level:
		current_level.queue_free()


func _on_game_start() -> void:
	current_level = GameState.levels[0].instantiate()
	add_child(current_level)


func _ready() -> void:
	EventBus.exit_to_menu.connect(_on_delete_level)
	EventBus.start_game.connect(_on_game_start)
