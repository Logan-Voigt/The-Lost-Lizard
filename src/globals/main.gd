extends Node2D

@onready var main_camera: MainCamera = $MainCamera
@onready var music_player: AudioStreamPlayer2D = $MusicPlayer

var current_level : Level

func _on_delete_level() -> void:
	if current_level:
		current_level.queue_free()


func _on_game_start() -> void:
	music_player.play()
	GameState.current_level = 0
	current_level = GameState.levels[GameState.current_level].instantiate()
	GameState.level_respawn_location = current_level.level_spawn
	main_camera.set_camera_limits(current_level.get_level_boarders())
	add_child(current_level)


func _on_start_level(number : int) -> void:
	if number >= GameState.levels.size():
		EventBus.exit_to_menu.emit()
		GameState.change_state(GameState.WIN_SCREEN)
		return
	_on_delete_level()
	GameState.current_level = number
	current_level = GameState.levels[GameState.current_level].instantiate()
	GameState.level_respawn_location = current_level.level_spawn
	main_camera.set_camera_limits(current_level.get_level_boarders())
	add_child(current_level)
	EventBus.respawn_player.emit()


func _ready() -> void:
	EventBus.exit_to_menu.connect(_on_delete_level)
	EventBus.start_game.connect(_on_game_start)
	EventBus.start_level.connect(_on_start_level)
