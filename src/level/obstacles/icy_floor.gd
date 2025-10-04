extends AnimatedSprite2D

var flipped = round(randf())
func _ready() -> void:
	if flipped:
		flip_h = true
