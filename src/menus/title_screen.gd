extends Node2D


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	visible = GameState.current_state == GameState.START_SCREEN


func _on_start_button_pressed() -> void:
	GameState.change_state(GameState.PLAYING)
	EventBus.start_game.emit()
