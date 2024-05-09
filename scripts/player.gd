extends CharacterBody2D

@export var is_controllable: bool = true
@export var speed = 300

@onready var sprite_2d: Sprite2D = $Sprite2D

var mouse_pos: Vector2

func move():
	var direction: Vector2 = get_input()
	if direction:
		velocity = direction * speed
	else:
		velocity = direction
	move_and_slide()
	
	mouse_pos = get_global_mouse_position()
	drone_look_at(mouse_pos)


func get_input():
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	return input_vector.normalized()


func drone_look_at(pos):
	look_at(pos)
	if pos.x <= global_position.x and sprite_2d.scale.y > 0:
		sprite_2d.scale.y *= -1
	elif pos.x > global_position.x and sprite_2d.scale.y <= 0:
		sprite_2d.scale.y *= -1

func _physics_process(delta):
	if is_controllable:
		move()
	
