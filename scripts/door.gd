extends Node2D
class_name Door

@export var is_open: bool = false
@export var next_scene: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var up_door: CollisionShape2D = $UpCollisionShape2D
@onready var down_door: CollisionShape2D = $DownCollisionShape2D

signal door_closed

func _ready():
	audio_player.volume_db = Global.SoundEffectsVolume
	if is_open:
		up_door.position = Vector2(0, -36)
		down_door.position = Vector2(0, 36)
	Events.volume_changed.connect(_on_volume_changed)

func _on_volume_changed():
	audio_player.volume_db = Global.SoundEffectsVolume

func open():
	animation_player.play("open")
	audio_player.play()
	Events.screen_shake.emit(10.0)
	is_open = true

func close():
	animation_player.play("close")
	audio_player.play()
	Events.screen_shake.emit(10.0)
	is_open = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "open":
		Events.screen_shake.emit(10.0)
	if anim_name == "close":
		Events.screen_shake.emit(10.0)
		door_closed.emit()
