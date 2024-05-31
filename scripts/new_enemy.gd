extends Enemy
class_name NewEnemy

var accel = 1000

#@onready var sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
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
	
func _physics_process(delta):
	if player != null:
		if detected:
			if can_move:
				enemy_look_at(player.global_position)
				follow_player(delta)
			if global_position.distance_to(player.global_position) >= losing_range:
				catch_sound.stop()
				peace_sound.playing = enemy_count < 20
				detected = false
		else:
			if global_position.distance_to(player.global_position) < detection_range:
				detected = true
				if catch_sound.playing == false:
					catch_sound.playing = true
				if peace_sound.playing:
					peace_sound.stop()

func _ready():
	peace_sound.volume_db = Global.EnemySoundsVolume
	catch_sound.volume_db = Global.EnemySoundsVolume
	add_to_group("enemies")
	can_move = false
	max_speed = 300
	knockback_force = 600.0
	peace_sound.playing = true
	count_enemies.call_deferred()
	Events.volume_changed.connect(_on_volume_changed)

func _on_volume_changed():
	peace_sound.volume_db = Global.EnemySoundsVolume
	catch_sound.volume_db = Global.EnemySoundsVolume

func act_on_detect():
	can_move = true

func act_on_conceal():
	can_move = false
