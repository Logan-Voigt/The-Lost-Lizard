extends Node

@onready var player_scene : PackedScene = load("res://src/player/player.tscn")
@onready var egg_scene : PackedScene = load("res://src/player/respawn_egg.tscn")
@onready var levels : Array[PackedScene] = [
	load("res://src/level/tutorial_level_0.tscn"),
	load("res://src/level/tutorial_level_1.tscn"), 
	load("res://src/level/tutorial_level_2.tscn"), 
	load("res://src/level/tutorial_level_3.tscn"), 
	load("res://src/level/tutorial_level_4.tscn"), 
	load("res://src/level/tutorial_level_5.tscn"),
	load("res://src/level/tutorial_level_6.tscn"),
	load("res://src/level/tutorial_level_7.tscn"),
	load("res://src/level/level_1.tscn"),
	load("res://src/level/level_2.tscn")]

const START_SCREEN : int = 0
const PAUSE_MENU : int = 1
const PLAYER_WAIT : int = 2
const PLAYING : int = 3
const WIN_SCREEN : int = 4
const LEVEL_SELECT : int = 5

const PLAIN : int = 0
const FIRE : int = 1
const ICE : int = 2
const TOXIC : int = 3

const RESPAWN_TIME : float = 0.5

var completed_levels : Array[bool] = [
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true]

var current_level : int
var current_state : int
var adaptation_type : int
var player_location : Vector2
var level_respawn_location : Vector2 = Vector2(947, 519)
var respawn_egg : Node2D

var wait_timer : float
var time_to_wait : float = -1.0
var function_call_after_wait : Callable

func is_playing() -> bool:
	return current_state == PLAYING


func is_in_game() -> bool:
	return current_state == PLAYING or current_state == PLAYER_WAIT or current_state == PAUSE_MENU


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
	if respawn_egg:
		new_player.global_position = respawn_egg.global_position
		respawn_egg.queue_free()
	else:
		new_player.global_position = level_respawn_location
	start_playing()


func set_player_location(location : Vector2) -> void:
	player_location = location


func setup_wait_state(function_to_call_on_completion : Callable = start_playing, wait_time : float = -1.0) -> void:
	change_state(PLAYER_WAIT)
	time_to_wait = wait_time
	function_call_after_wait = function_to_call_on_completion


func exit_wait_state() -> void:
	wait_timer = 0.0
	time_to_wait = -1.0
	function_call_after_wait.call()


func start_playing():
	change_state(PLAYING)


func _on_start_game() -> void:
	adaptation_type = PLAIN
	start_playing()
	call_deferred("respawn_player")


func _on_start_level(_number : int) -> void:
	adaptation_type = PLAIN


func _on_player_respawn() -> void:
	setup_wait_state(respawn_player, RESPAWN_TIME)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		change_state(START_SCREEN)
		EventBus.exit_to_menu.emit()
	if event.is_action_pressed("set_egg") and is_playing():
		if respawn_egg:
			respawn_egg.queue_free()
		respawn_egg = egg_scene.instantiate()
		get_tree().root.get_node("Main").add_child(respawn_egg)
		respawn_egg.global_position = player_location

func _physics_process(delta: float) -> void:
	if current_state == PLAYER_WAIT and time_to_wait > 0:
		wait_timer += delta
		if wait_timer > time_to_wait:
			exit_wait_state()


func _ready() -> void:
	EventBus.respawn_player.connect(_on_player_respawn)
	EventBus.start_game.connect(_on_start_game)
	EventBus.start_level.connect(_on_start_level)
	current_state = START_SCREEN
	adaptation_type = PLAIN
