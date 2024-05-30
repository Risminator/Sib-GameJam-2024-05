extends CharacterBody2D
class_name Enemy

@export var max_speed = 250
@export var friction = 5000

var attack_damage: int = 1
var knockback_force: float = 500.0

var can_move: bool = true
var detected: bool = false
@export var player: CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var peace_sound: AudioStreamPlayer2D = $PeaceSound
@onready var catch_sound: AudioStreamPlayer2D = $CatchSound

func _ready():
	peace_sound.playing = true

var direction: Vector2 = Vector2.ZERO

func follow_player(delta):
	direction = global_position.direction_to(player.global_position)
	if direction == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (direction * max_speed)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func _physics_process(delta):
	if player != null:
		if detected:
			if can_move:
				enemy_look_at(player.global_position)
				follow_player(delta)
			if global_position.distance_to(player.global_position) >= 300.0:
				catch_sound.stop()
				peace_sound.playing = true
				detected = false
		else:
			if global_position.distance_to(player.global_position) < 200.0:
				detected = true
				if catch_sound.playing == false:
					catch_sound.playing = true
				peace_sound.stop()

func enemy_look_at(pos):
	look_at(pos)
	if pos.x <= global_position.x and scale.y >= 0:
		scale.y *= -1
	elif pos.x > global_position.x and scale.y < 0:
		scale.y *= -1

func act_on_detect():
	can_move = false

func act_on_conceal():
	can_move = true

func _on_enemy_hitbox_area_entered(area):
	if area.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		area.damage(attack)
