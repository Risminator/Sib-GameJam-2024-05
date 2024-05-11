extends Node

const SCENES = {
	MAIN = "menus/main",
	ROOM1 = "levels/room1",
	ROOM2 = "levels/room2",
	A = "levels/a",
	CUTSCENE = "menus/cutscene"
}

func set_scene(scene_name: String):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")

func set_level_scene(scene_name: String):
	set_scene("levels/" + scene_name)

func set_menu_scene(scene_name: String):
	set_scene("menus/" + scene_name)

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		set_scene(SCENES.A)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
