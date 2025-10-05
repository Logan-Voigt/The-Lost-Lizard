extends Node2D


func _process(_delta: float) -> void:
	visible = GameState.current_state == GameState.PAUSE_MENU
	GameState.player_freeze = (GameState.current_state == GameState.PAUSE_MENU)

func _on_main_menu_pressed() -> void:
	GameState.change_state(GameState.START_SCREEN)
	EventBus.exit_to_menu.emit() 
	# Replace with function body.


func _on_restart_level_pressed() -> void:
	GameState.restart()


func _on_continue_pressed() -> void:
	GameState.player_freeze = false
	GameState.change_state(GameState.PLAYING)
	 # Replace with function body.
