extends Node2D

func _on_level_button_pressed(level_number : int) -> void:
	EventBus.start_level.emit(level_number)


func _process(_delta: float) -> void:
	visible = GameState.current_state == GameState.LEVEL_SELECT
	if GameState.current_state == GameState.LEVEL_SELECT:
		for i in range(get_child_count()):
			if get_child(i) is Button:
				var level_button : Button = get_child(i)
				level_button.disabled = not GameState.completed_levels[i]


func _ready() -> void:
	for i in range(get_child_count()):
		if get_child(i) is Button:
			var level_button : Button = get_child(i)
			level_button.pressed.connect(_on_level_button_pressed.bind(i))
