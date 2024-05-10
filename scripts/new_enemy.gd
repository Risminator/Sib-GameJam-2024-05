extends Enemy
class_name NewEnemy

var accel = 1000

func follow_player(delta):
	direction = global_position.direction_to(player.global_position)
	if direction == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (direction * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func _ready():
	can_move = false
	max_speed = 300
	knockback_force = 600.0

func act_on_detect():
	can_move = true

func act_on_conceal():
	can_move = false
