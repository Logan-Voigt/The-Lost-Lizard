extends Node

const START_SCREEN : int = 0
const PAUSE_MENU : int = 1
const PLAYER_WAIT : int = 2
const PLAYING : int = 3

const PLAIN : int = 0
const FIRE : int = 1
const ICE : int = 2
const TOXIC : int = 3

var current_state : int
var adaptation_type : int

func is_playing() -> bool:
	return current_state == PLAYING


func get_adaptation_type() -> int:
	return adaptation_type


func set_adaptation_type(type : int) -> void:
	adaptation_type = type


func _ready() -> void:
	current_state = PLAYING
	adaptation_type = PLAIN
