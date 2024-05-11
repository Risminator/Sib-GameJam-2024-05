extends StaticBody2D

@export var door: Door

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	modulate = door.modulate


func _on_area_2d_body_entered(_body):
	if !door.is_open:
		door.open()
		animation_player.play("pressed")
