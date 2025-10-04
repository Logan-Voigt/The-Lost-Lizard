extends Node2D

func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	visible = GameState.current_state == GameState.WIN_SCREEN
