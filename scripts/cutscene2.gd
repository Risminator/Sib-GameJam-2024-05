extends Cutscene

func _process(_delta):
	if Input.is_action_just_pressed("toggle_light") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		if frame == framesN - 1:
			transition.fade_in()
			await Events.fade_in_finished
			Global.set_level_scene("last1")
		else:
			frame += 1
			match frame:
				1, 3:
					transition.fade_in()
					await Events.fade_in_finished
			texture_rect.texture.region.position.x = frame * 640
			match frame:
				1, 3:
					transition.fade_out()
				2:
					Events.screen_shake.emit(10.0)
	if Input.is_action_just_pressed("backwards") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
		if frame > 0:
			frame -= 1
			texture_rect.texture.region.position.x = frame * 640
