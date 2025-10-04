extends Node2D

@onready var main_camera: MainCamera = $MainCamera

var current_level : Level

func _on_delete_level() -> void:
	if current_level:
		current_level.queue_free()


func _on_game_start() -> void:
	current_level = GameState.levels[0].instantiate()
	main_camera.set_camera_limits(current_level.get_level_boarders())
	add_child(current_level)


func _ready() -> void:
	EventBus.exit_to_menu.connect(_on_delete_level)
	EventBus.start_game.connect(_on_game_start)
