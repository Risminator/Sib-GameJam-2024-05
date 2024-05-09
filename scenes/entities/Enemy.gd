extends CharacterBody2D
class_name Enemy

@export var max_speed = 300
@export var accel = 1000
@export var friction = 3000

var can_move: bool = true
var detected: bool = false
@export var player: CharacterBody2D = null

@onready var sprite_2d: Sprite2D = $Sprite2D

var direction: Vector2 = Vector2.ZERO

func follow_player(delta):
	direction = global_position.direction_to(player.global_position)
	look_at(player.global_position)
	if direction == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (direction * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move and player != null:
		follow_player(delta)

func enemy_look_at(pos):
	look_at(pos)
	if pos.x <= global_position.x and sprite_2d.scale.y > 0:
		sprite_2d.scale.y *= -1
	elif pos.x > global_position.x and sprite_2d.scale.y <= 0:
		sprite_2d.scale.y *= -1

func act_on_detect():
	can_move = false

func act_on_conceal():
	can_move = true
