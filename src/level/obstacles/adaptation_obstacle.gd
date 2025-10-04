extends Node2D

@export var obstacle_data : ObstacleData
@onready var effect_area_collision: CollisionShape2D = $EffectArea/CollisionShape2D
@onready var effect_area: Area2D = $EffectArea
@onready var effect_staticbody_collision: CollisionShape2D = $EffectStaticbody/CollisionShape2D
@onready var effect_staticbody: StaticBody2D = $EffectStaticbody
@onready var main_texture: AnimatedSprite2D = $Main_Texture
@onready var secondary_texture: Sprite2D = $Secondary_Texture
var frames : SpriteFrames = SpriteFrames.new()

const NONE : int = 0
const STOP : int = 1
const PUSH : int = 2
const SLIDE : int = 3

const PLAYER_LAYER : int = 1

var pushing_x : int 
var pushing_y : int 
var player : Player 

var death_timer : float

func kill_player() -> void:
	GameState.set_adaptation_type(obstacle_data.damage_type)
	EventBus.respawn_player.emit()


func reset_obstacle() -> void:
	effect_staticbody.collision_layer = 0


func match_the_effect(type_of_effect : int) -> void:
	match type_of_effect:
		STOP:
			effect_staticbody.collision_layer = PLAYER_LAYER
		PUSH:
			player.add_external_force(transform.y * -obstacle_data.pushing_power)
		SLIDE:
			player.is_sliding = true
		_:
			pass


func apply_matching_effects() -> void:
	match_the_effect(obstacle_data.matching_effect)


func apply_differing_effects(delta: float) -> void:
	if obstacle_data.instant_death:
		kill_player()
		return
	if obstacle_data.death_timer_limit > 0.0:
		death_timer += delta
		if death_timer > obstacle_data.death_timer_limit:
			kill_player()
			return
	match_the_effect(obstacle_data.differing_effect)


func apply_always_effects() -> void:
	if obstacle_data.kill_no_matter:
		kill_player()
		return
	match_the_effect(obstacle_data.always_effect)

func _on_effect_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_effect_area_body_exited(body: Node2D) -> void:
	if body is Player:
		death_timer = 0.0
		player = null
	
		


func _on_type_changed() -> void:
	reset_obstacle()


func _physics_process(delta: float) -> void:
	if not player: return
	if obstacle_data.damage_type == GameState.adaptation_type:
		apply_matching_effects()
	else:
		apply_differing_effects(delta)
	apply_always_effects()


func _ready() -> void:
	EventBus.type_changed.connect(_on_type_changed)
	main_texture.play("default")
	
