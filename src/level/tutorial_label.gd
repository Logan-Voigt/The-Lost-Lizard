extends RichTextLabel

var text_zone : Area2D

func _ready() -> void:
	visible = false
	if get_child_count() != 1:
		print("label needs one area2D child on level ", GameState.current_level)
		return
	text_zone = get_child(0)
	text_zone.body_entered.connect(_on_area_2d_body_entered)
	text_zone.body_exited.connect(_on_area_2d_body_exited)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		visible = false
