extends CharacterBody2D

@export var is_controllable: bool = true
@export var max_speed = 300
@export var accel = 1000
@export var friction = 2000


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var vision_cone: Area2D = $VisionCone
@onready var cone_collision_mask: int = vision_cone.collision_mask

@onready var drone_sounds: AudioStreamPlayer = $DroneSound
#@onready var water_ambient: AudioStreamPlayer = $WaterAmbientSound

# sound stuff
var drone_bus: AudioEffect = AudioServer.get_bus_effect(1, 0)

var direction: Vector2 = Vector2.ZERO
var mouse_pos: Vector2

func _ready(): 
	drone_sounds.playing = true 
	#water_ambient.playing = true	

func move(delta):
	direction = get_input()
	if direction == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (direction * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()
	
	mouse_pos = get_global_mouse_position()
	drone_look_at(mouse_pos)
	
	drone_bus.pitch_scale = 0.5 + velocity.length() * 0.001

func toggle_light():
	if vision_cone.collision_mask == cone_collision_mask:
		vision_cone.collision_mask = 0
		vision_cone.visible = false
	else:
		vision_cone.collision_mask = cone_collision_mask
		vision_cone.visible = true

func get_input():
	if Input.is_action_just_pressed("toggle_light"):
		toggle_light()
	
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	return input_vector.normalized()


func drone_look_at(pos):
	look_at(pos)
	if pos.x <= global_position.x and sprite_2d.scale.y < 0:
		sprite_2d.scale.y *= -1
	elif pos.x > global_position.x and sprite_2d.scale.y >= 0:
		sprite_2d.scale.y *= -1

func _physics_process(delta):
	if is_controllable:
		move(delta)
	


func _on_vision_cone_area_entered(area):
	var body = area.get_parent()
	if body.has_method("act_on_detect"):
		body.act_on_detect()
		


func _on_vision_cone_area_exited(area):
	var body = area.get_parent()
	if body.has_method("act_on_conceal"):
		body.act_on_conceal()
