extends Area2D

@onready var door: Door = get_parent()


func change_scene():
	Global.set_level_scene(door.next_scene)

func _on_body_entered(_body):
	Events.room_left.emit()
	await Events.fade_in_finished
	change_scene.call_deferred()
