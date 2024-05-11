extends Node2D


func _on_player_detector_body_entered(_body):
	Events.room_entered.emit(self)
