extends StaticBody2D

@export var door: Door

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	modulate = door.modulate


func _on_area_2d_body_entered(_body):
	if !door.is_open:
		door.open()
		animation_player.play("pressed")
		sound_player.play()
