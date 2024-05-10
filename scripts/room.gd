extends Node2D


func _on_player_detector_body_entered(body):
	Events.room_entered.emit(self)
