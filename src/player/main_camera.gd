class_name MainCamera extends Camera2D

const CAMERA_DIMENTIONS : Vector2 = Vector2(1920, 1080)
var camera_limits : Vector4

func set_camera_limits(limits : Vector4) -> void:
	camera_limits = limits


func _process(_delta: float) -> void:
	if not GameState.is_in_game():
		global_position = CAMERA_DIMENTIONS / 2
		return
	
	global_position = GameState.player_location.clamp(Vector2(camera_limits.x, camera_limits.y) + CAMERA_DIMENTIONS / 2, Vector2(camera_limits.z, camera_limits.w) - CAMERA_DIMENTIONS / 2)
