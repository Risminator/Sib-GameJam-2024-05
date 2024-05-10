extends StaticBody2D

@export var door: Door

func _ready():
	modulate = door.modulate


func _on_area_2d_body_entered(body):
	if !door.is_open:
		door.open()
