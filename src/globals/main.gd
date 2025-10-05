extends Node2D

@onready var main_camera: MainCamera = $MainCamera
@onready var music_player: AudioStreamPlayer2D = $MusicPlayer
@onready var cave_music_player: AudioStreamPlayer2D = $CaveMusicPlayer
@onready var intermission_screen: Node2D = $IntermissionScreen
@onready var tutorial_sfx: AudioStreamPlayer2D = $TutorialSfx
@onready var level_sfx: AudioStreamPlayer2D = $LevelSfx


var current_level : Level

func delete_level() -> void:
	if current_level:
		current_level.queue_free()


func _on_game_start(level : int) -> void:
	delete_level()
	if level < 8:
		music_player.play()
		cave_music_player.stop()
		tutorial_sfx.play()
		level_sfx.stop()
	else:
		cave_music_player.play()
		music_player.stop()
		tutorial_sfx.stop()
		level_sfx.play()
	GameState.current_level = level
	current_level = GameState.levels[GameState.current_level].instantiate()
	GameState.level_respawn_location = current_level.level_spawn
	main_camera.set_camera_limits(current_level.get_level_boarders())
	add_child(current_level)


func _on_start_level(number : int) -> void:
	if number >= GameState.levels.size():
		EventBus.exit_to_menu.emit()
		GameState.change_state(GameState.WIN_SCREEN)
		return
	delete_level()
	GameState.current_level = number
	current_level = GameState.levels[GameState.current_level].instantiate()
	GameState.level_respawn_location = current_level.level_spawn
	main_camera.set_camera_limits(current_level.get_level_boarders())
	add_child(current_level)
	EventBus.respawn_player.emit()


func _on_exit_to_menu() -> void:
	delete_level()
	music_player.stop()
	cave_music_player.stop()
	tutorial_sfx.stop()
	level_sfx.stop()


func _on_show_intermission() -> void:
	intermission_screen.visible = true


func _on_hide_intermission() -> void:
	intermission_screen.visible = false
	
func _ready() -> void:
	EventBus.exit_to_menu.connect(_on_exit_to_menu)
	EventBus.start_game.connect(_on_game_start)
	EventBus.start_level.connect(_on_start_level)
	EventBus.show_intermission.connect(_on_show_intermission)
	EventBus.hide_intermission.connect(_on_hide_intermission)
