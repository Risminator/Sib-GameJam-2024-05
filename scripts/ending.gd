extends Control


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		Global.set_scene(Global.SCENES.MAIN)
