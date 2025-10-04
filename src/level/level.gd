class_name Level extends Node2D

@export var level_min : Vector2
@export var level_max : Vector2
@export var level_spawn : Vector2

func get_level_boarders() -> Vector4:
	return Vector4(level_min.x, level_min.y, level_max.x, level_max.y)
