extends Actor

func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x

func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	set_sprite_direction()

func set_sprite_direction():
	if _velocity.x < 0:
		get_node("AnimatedSprite").set_flip_h(false)
	if _velocity.x > 0:
		get_node("AnimatedSprite").set_flip_h(true)
