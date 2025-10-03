class_name Player extends CharacterBody2D

@onready var player_sprite : AnimatedSprite2D = $Visuals

const SPEED : float = 500.0
const JUMP_VELOCITY : float = -700.0
const GRAVITY_MULTIPLIER : float = 4
const JUMPING_GRAVITY_MULTIPLIER : float = 2
const STORED_JUMP_MAX_TIME : float = 0.5

var stored_jump : bool = false
var stored_jump_timer : float = 0.0

var being_pushed : bool 
var external_forces : Array[Vector2]

func add_external_force(force : Vector2) -> void:
	external_forces.append(force)


func apply_forces(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0 and Input.is_action_pressed("move_jump"):
			velocity += get_gravity() * delta * JUMPING_GRAVITY_MULTIPLIER
		else:
			velocity += get_gravity() * delta * GRAVITY_MULTIPLIER 
	while not external_forces.is_empty():
		velocity += external_forces.pop_front()

func handle_jumping(delta: float) -> void:
	# stored_jump allows you to press jump a little bit early but have it still count
	if not is_on_floor():
		player_sprite.play("jump")
	if Input.is_action_just_pressed("move_jump") and not is_on_floor():
		stored_jump = true
		stored_jump_timer = 0.0
	if stored_jump:
		stored_jump_timer += delta
		if not Input.is_action_pressed("move_jump") or stored_jump_timer > STORED_JUMP_MAX_TIME:
			stored_jump = false
	
	if (Input.is_action_just_pressed("move_jump") or stored_jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY


func handle_movement() -> void:
	var direction : float = Input.get_axis("move_left", "move_right")
	if direction:
		player_sprite.play("walking")
		velocity.x = direction * SPEED
	else:
		player_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_graphics() -> void:
	if Input.is_action_pressed("move_left"):
		player_sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		player_sprite.flip_h = false


func _on_delete_self() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	handle_movement()
	apply_forces(delta)
	handle_jumping(delta)
	handle_graphics()
	move_and_slide()
	GameState.set_player_location(global_position)


func _ready() -> void:
	EventBus.respawn_player.connect(_on_delete_self)
	EventBus.exit_to_menu.connect(_on_delete_self)
