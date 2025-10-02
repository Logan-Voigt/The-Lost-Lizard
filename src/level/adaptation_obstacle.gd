extends Node2D

@export var obstacle_data : ObstacleData
@export var obstacle_hitbox : RectangleShape2D
@export var secondary_image : CompressedTexture2D
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

var player_is_colliding : bool
var death_timer : float

func kill_player() -> void:
	GameState.set_adaptation_type(obstacle_data.damage_type)
	EventBus.respawn_player.emit()


func reset_obstacle() -> void:
	effect_staticbody.collision_layer = 0


func apply_matching_effects(delta) -> void:
	if obstacle_data.kill_no_matter:
		apply_differing_effects(delta)
	match obstacle_data.matching_effect:
		STOP:
			effect_staticbody.collision_layer = PLAYER_LAYER
		PUSH:
			pass
		SLIDE:
			pass
		_:
			pass


func apply_differing_effects(delta: float) -> void:
	if obstacle_data.instant_death:
		kill_player()
		return
	if obstacle_data.death_timer_limit > 0.0:
		death_timer += delta
		if death_timer > obstacle_data.death_timer_limit:
			kill_player()
			return


func apply_always_effects() -> void:
	pass


func _on_effect_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_is_colliding = true


func _on_effect_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_is_colliding = false
		death_timer = 0.0


func _on_type_changed() -> void:
	reset_obstacle()


func _physics_process(delta: float) -> void:
	if not player_is_colliding: return
	if obstacle_data.damage_type == GameState.adaptation_type:
		apply_matching_effects(delta)
	else:
		apply_differing_effects(delta)
	apply_always_effects()


func _ready() -> void:
	EventBus.type_changed.connect(_on_type_changed)
	
	effect_area_collision.shape = obstacle_hitbox
	effect_staticbody_collision.shape = obstacle_hitbox
	effect_area_collision.position.y -= obstacle_hitbox.size.y / 2
	effect_staticbody_collision.position.y -= obstacle_hitbox.size.y / 2
	
	frames.add_animation("default")
	frames.add_frame("default", obstacle_data.main_image)
	main_texture.sprite_frames = frames
	secondary_texture.texture = secondary_image
	
