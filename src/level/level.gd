class_name Level extends Node2D

@export var level_min : Vector2
@export var level_max : Vector2
@export var level_spawn : Vector2
@export var tutorial_audio_offset : float

func get_level_boarders() -> Vector4:
	return Vector4(level_min.x, level_min.y, level_max.x, level_max.y)


func _ready() -> void:
	if get_child(0) is AudioStreamPlayer2D:
		get_child(0).play(tutorial_audio_offset)
