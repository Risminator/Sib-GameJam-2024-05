extends Enemy
class_name BigEnemy

@onready var timer: Timer = $Timer
@onready var light: PointLight2D = $PointLight2D
@onready var area: Area2D = $EnemyHitbox
@onready var hitbox_collision: CollisionShape2D = $EnemyHitbox/CollisionShape2D

const MODES = {
	STOP_AT_SIGHT = 0,
	STOP_AT_CONCEAL = 1
}

var mode = MODES.STOP_AT_SIGHT
var timer_started = false

var is_under_flashlight: bool = false

var is_in_cage = false
var is_trapped = false

func _ready():
	peace_sound.volume_db = Global.EnemySoundsVolume
	catch_sound.volume_db = Global.EnemySoundsVolume
	add_to_group("enemies")
	losing_range = 500.0
	detection_range = 400.0
	Events.volume_changed.connect(_on_volume_changed)

func _on_volume_changed():
	peace_sound.volume_db = Global.EnemySoundsVolume
	catch_sound.volume_db = Global.EnemySoundsVolume

func act_on_detect():
	is_under_flashlight = true
	match mode:
		MODES.STOP_AT_SIGHT:
			can_move = false
			if !timer_started:
				timer.start()
				timer_started = true
		MODES.STOP_AT_CONCEAL:
			can_move = true

func act_on_conceal():
	is_under_flashlight = false
	match mode:
		MODES.STOP_AT_SIGHT:
			can_move = true
		MODES.STOP_AT_CONCEAL:
			can_move = false
			if !timer_started:
				timer.start()
				timer_started = true

func _process(_delta):
	match mode:
		MODES.STOP_AT_SIGHT:
			if timer_started:
				light.color = Color.hex((int(0xff * ((timer.wait_time - timer.time_left) / timer.wait_time)) << 24) + (light.color.to_rgba32() & 0x00ffffff))
				sprite_2d.self_modulate = Color.hex((0xff - int((0xff - 0x24) * ((timer.wait_time - timer.time_left) / timer.wait_time)) << 8) + (sprite_2d.self_modulate.to_rgba32() & 0xffff00ff))
			else:
				sprite_2d.self_modulate = Color.hex(0x6100ffff)
				light.color = Color.hex(0x00549dff)
		MODES.STOP_AT_CONCEAL:
			if timer_started:
				light.color = Color.hex((int(0xff * (timer.time_left / timer.wait_time)) << 24) + (light.color.to_rgba32() & 0x00ffffff))
				sprite_2d.self_modulate = Color.hex((0xff - int((0xff - 0x24) * (timer.time_left / timer.wait_time)) << 8) + (sprite_2d.self_modulate.to_rgba32() & 0xffff00ff))
			else:
				sprite_2d.self_modulate = Color.hex(0x610024ff)
				light.color = Color.hex(0xff549dff)


func _on_timer_timeout():
	print(is_trapped)
	mode ^= 1
	timer_started = false
	var areas: Array[Area2D] = area.get_overlapping_areas()
	for a in areas:
		if a.has_node("Mask") and a.monitoring:
			is_under_flashlight = true
	if is_under_flashlight:
		act_on_detect()
	else:
		act_on_conceal()
	
