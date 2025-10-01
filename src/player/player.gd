class_name Player extends CharacterBody2D


const SPEED : float = 500.0
const JUMP_VELOCITY : float = -600.0
const GRAVITY_MULTIPLIER : float = 3
const STORED_JUMP_MAX_TIME : float = 0.5

var stored_jump : bool = false
var stored_jump_timer : float = 0.0

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0 and Input.is_action_pressed("move_jump"):
			velocity += get_gravity() * delta 
		else:
			velocity += get_gravity() * delta * GRAVITY_MULTIPLIER 


func handle_jumping(delta: float) -> void:
	# stored_jump allows you to press jump a little bit early but have it still count
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
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_jumping(delta)
	handle_movement()
	move_and_slide()
