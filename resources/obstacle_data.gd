class_name ObstacleData extends Resource

@export_enum("plain", "fire", "ice", "toxic", "none") var damage_type : int
@export var instant_death : bool
@export var death_timer : float
@export_enum("plain", "fire", "ice", "toxic", "none") var destroyed_by_type : int
