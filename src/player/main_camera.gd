extends Camera2D

const CAMERA_DIMENTIONS : Vector2 = Vector2(1920, 1080)
# TODO: set from level data
var camera_limits : Vector4 = Vector4(-120, -500, 1900, 760)

func _process(delta: float) -> void:
	if not GameState.is_in_game():
		global_position = CAMERA_DIMENTIONS / 2
		return
	
	global_position = GameState.player_location.clamp(Vector2(camera_limits.x, camera_limits.y) + CAMERA_DIMENTIONS / 2, Vector2(camera_limits.z, camera_limits.w) - CAMERA_DIMENTIONS / 2)
