extends Area2D

@onready var door: Door = get_parent()

func change_scene():
	Global.set_level_scene(door.next_scene)

func _on_body_entered(_body):
	Events.room_left.emit()
	call_deferred("change_scene")
	#body.global_position = marker_2d.global_position
