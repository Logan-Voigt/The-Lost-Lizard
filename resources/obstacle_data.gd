class_name ObstacleData extends Resource

@export_enum("plain", "fire", "ice", "toxic", "none") var damage_type : int
@export var instant_death : bool
@export var death_timer_limit : float
@export_enum("plain", "fire", "ice", "toxic", "none") var destroyed_by_type : int
@export_enum("none", "stop", "push", "slide") var matching_effect
@export_enum("none", "stop", "push", "slide") var differing_effect
@export_enum("none", "stop", "push", "slide") var always_effect
@export var main_image : CompressedTexture2D
