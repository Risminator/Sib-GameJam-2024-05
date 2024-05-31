extends StaticBody2D
class_name DoorButton

@export var door: Door

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready():
	sound_player.volume_db = Global.SoundEffectsVolume
	modulate = door.modulate
	Events.volume_changed.connect(_on_volume_changed)

func _on_volume_changed():
	sound_player.volume_db = Global.SoundEffectsVolume


func _on_area_2d_body_entered(_body):
	if !door.is_open:
		door.open()
		animation_player.play("pressed")
		sound_player.play()
