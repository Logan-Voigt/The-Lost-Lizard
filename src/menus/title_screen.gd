extends Node2D

@onready var start_button: Button = $StartButton

func _ready() -> void:
	visible = true


func _process(_delta: float) -> void:
	visible = GameState.current_state == GameState.START_SCREEN


func _on_start_button_pressed() -> void:
	start_button.disabled = true
	GameState.change_state(GameState.PLAYING)
	EventBus.start_game.emit()
