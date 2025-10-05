extends Node2D

@onready var win_sound: AudioStreamPlayer2D = $win_sound

var first_time_winning : bool
var timer : int = 0
@onready var main_menu_btn : Button = $"Back to main menu"
@onready var main_btn_timer : Timer = $Timer

func _ready() -> void:
	main_menu_btn.visible = false
	visible = false
	first_time_winning = true


func _process(_delta: float) -> void:
	visible = GameState.current_state == GameState.WIN_SCREEN
	if visible and first_time_winning:
		first_time_winning = false
		win_sound.play()
		main_btn_timer.start()

func _on_timer_timeout() -> void:
	main_menu_btn.visible = true # Replace with function body.


func _on_back_to_main_menu_pressed() -> void:
	GameState.change_state(GameState.START_SCREEN)  # Replace with function body.
