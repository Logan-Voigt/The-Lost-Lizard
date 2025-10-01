extends Node2D

@export var obstacle_data : ObstacleData

@onready var effect_area: Area2D = $EffectArea

const DAMAGE_TICK_RATE : float = 0.5

var player_is_colliding : bool

func _on_effect_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_is_colliding = true


func _on_effect_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_is_colliding = false


func _physics_process(delta: float) -> void:
	if 
