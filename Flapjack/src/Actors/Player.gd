extends Actor

var _jumpcount = 0

func _physics_process(delta):
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	set_sprite_direction()
	if is_on_floor():
		_jumpcount = 0


func set_sprite_direction():
	if _velocity.x > 0:
		get_node("AnimatedSprite").set_flip_h(false)
	if _velocity.x < 0:
		get_node("AnimatedSprite").set_flip_h(true)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		get_y_direction()
	)


func get_y_direction() -> float:
	# return -1 if we want player to jump else return 1 for falling
	if Input.is_action_just_pressed("jump"):
		print("space was pressed")
		if _jumpcount <= 1:
			_jumpcount += 1
			return -1.0
	return 1.0


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	return out
