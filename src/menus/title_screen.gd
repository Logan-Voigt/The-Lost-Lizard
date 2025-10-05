extends Node2D

@onready var start_button: Button = $StartButton
@onready var level_select_button: Button = $LevelSelectButton

func _ready() -> void:
	visible = true


func _process(_delta: float) -> void:
	if GameState.current_state == GameState.START_SCREEN:
		start_button.disabled = false
		level_select_button.disabled = false
	visible = GameState.current_state == GameState.START_SCREEN


func _on_start_button_pressed() -> void:
	GameState.change_state(GameState.PLAYING)
	start_button.disabled = true
	level_select_button.disabled = true
	EventBus.start_game.emit()


func _on_level_select_button_pressed() -> void:
	GameState.change_state(GameState.LEVEL_SELECT)
	level_select_button.disabled = true
	start_button.disabled = true
