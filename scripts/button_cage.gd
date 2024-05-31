extends DoorButton
class_name CageButton

@export var door2: Door

signal pressed

func _on_area_2d_body_entered(_body):
	if !door.is_open:
		door.open()
		door2.open()
		animation_player.play("pressed_and_released")
		sound_player.play()
	else:
		door.close()
		door2.close()
		animation_player.play("pressed_and_released")
		sound_player.play()
	pressed.emit()
