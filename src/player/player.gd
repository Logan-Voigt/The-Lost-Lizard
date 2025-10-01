extends CharacterBody2D


const SPEED : float = 500.0
const JUMP_VELOCITY : float = -600.0
const GRAVITY_MULTIPLIER : float = 3


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y < 0 and Input.is_action_pressed("move_jump"):
			velocity += get_gravity() * delta 
		else:
			velocity += get_gravity() * delta * GRAVITY_MULTIPLIER 

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
