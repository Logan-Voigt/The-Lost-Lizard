extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = GameState.current_state == GameState.START_SCREEN


func _on_start_button_pressed() -> void:
	GameState.change_state(GameState.PLAYING)
	EventBus.start_game.emit()
