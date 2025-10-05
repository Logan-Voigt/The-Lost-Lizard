extends Node2D

@onready var win_sound: AudioStreamPlayer2D = $win_sound

var first_time_winning : bool

func _ready() -> void:
	visible = false
	first_time_winning = true


func _process(_delta: float) -> void:
	visible = GameState.current_state == GameState.WIN_SCREEN
	if visible and first_time_winning:
		first_time_winning = false
		win_sound.play()
