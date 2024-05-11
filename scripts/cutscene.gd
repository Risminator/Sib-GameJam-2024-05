extends Node

@onready var cutscene_frame: Sprite2D = $Frame

func _ready():
	cutscene_frame.frame = 0
	
func _process(delta):
	if Input.is_action_just_pressed("toggle_light") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		if cutscene_frame.frame == cutscene_frame.hframes - 1:
			Global.set_level_scene("a")
		else:
			Events.room_left.emit()
			cutscene_frame.frame += 1
			if cutscene_frame.frame == 1:
				Events.screen_shake.emit(20.0)
			elif cutscene_frame.frame == 3:
				Events.screen_shake.emit(5.0)
			elif cutscene_frame.frame == 7:
				Events.screen_shake.emit(5.0)
	if Input.is_action_just_pressed("backwards") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
		if cutscene_frame.frame > 0:
			cutscene_frame.frame -= 1
