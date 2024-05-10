extends Node2D
class_name Door

@export var is_open: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var up_door: CollisionShape2D = $UpCollisionShape2D
@onready var down_door: CollisionShape2D = $DownCollisionShape2D

func _ready():
	if is_open:
		up_door.position = Vector2(0, -36)
		down_door.position = Vector2(0, 36)
		

func open():
	animation_player.play("open")
	audio_player.play()
	is_open = true
