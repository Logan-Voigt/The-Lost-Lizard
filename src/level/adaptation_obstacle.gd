extends Node2D

@export var obstacle_data : ObstacleData

@onready var effect_area: Area2D = $EffectArea

var player_is_colliding : bool

func apply_matching_effects() -> void:
	pass


func apply_differing_effects() -> void:
	if obstacle_data.instant_death:
		GameState.set_adaptation_type(obstacle_data.damage_type)
		EventBus.respawn_player.emit()
		print("dead")


func apply_always_effects() -> void:
	pass


func _on_effect_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_is_colliding = true


func _on_effect_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_is_colliding = false


func _physics_process(delta: float) -> void:
	if not player_is_colliding: return
	if obstacle_data.damage_type == GameState.adaptation_type:
		apply_matching_effects()
	else:
		apply_differing_effects()
	apply_always_effects()
