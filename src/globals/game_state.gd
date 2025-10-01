extends Node

@onready var player_scene : PackedScene = load("res://src/player/player.tscn")

const START_SCREEN : int = 0
const PAUSE_MENU : int = 1
const PLAYER_WAIT : int = 2
const PLAYING : int = 3

const PLAIN : int = 0
const FIRE : int = 1
const ICE : int = 2
const TOXIC : int = 3

const RESPAWN_TIME : float = 0.5

var current_state : int
var adaptation_type : int
var respawn_location : Vector2 = Vector2(947, 519)

var wait_timer : float
var time_to_wait : float = -1.0
var function_call_after_wait : Callable

func is_playing() -> bool:
	return current_state == PLAYING


func get_adaptation_type() -> int:
	return adaptation_type


func set_adaptation_type(type : int) -> void:
	if adaptation_type == type: return
	EventBus.type_changed.emit()
	adaptation_type = type


func change_state(state : int) -> void:
	current_state = state


func respawn_player() -> void:
	var new_player : Player = player_scene.instantiate()
	get_tree().root.get_node("Main").add_child(new_player)
	new_player.position = respawn_location


func setup_wait_state(function_to_call_on_completion : Callable = start_playing, wait_time : float = -1.0) -> void:
	change_state(PLAYER_WAIT)
	time_to_wait = wait_time
	function_call_after_wait = respawn_player


func exit_wait_state() -> void:
	wait_timer = 0.0
	time_to_wait = -1.0
	function_call_after_wait.call()


func start_playing():
	change_state(PLAYING)


func _on_player_respawn() -> void:
	setup_wait_state(respawn_player, RESPAWN_TIME)


func _physics_process(delta: float) -> void:
	if current_state == PLAYER_WAIT and time_to_wait > 0:
		wait_timer += delta
		if wait_timer > time_to_wait:
			exit_wait_state()


func _ready() -> void:
	EventBus.respawn_player.connect(_on_player_respawn)
	current_state = PLAYING
	adaptation_type = PLAIN
