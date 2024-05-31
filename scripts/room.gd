extends Node2D


func cutscene():
	Events.room_left.emit()
	await Events.fade_in_finished
	Global.set_scene(Global.SCENES.CUTSCENE2)


func _on_cutscene_area_body_entered(body):
	cutscene.call_deferred()
