extends Node

const SCENES = {
	MAIN = "menus/main",
	LEVEL = "levels/level"
}

func set_scene(scene_name: String):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		set_scene(SCENES.LEVEL)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
