extends Node

const SCENES = {
	MAIN = "menus/main",
	LEVEL = "levels/level"
}

func set_scene(scene_name: String):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")
