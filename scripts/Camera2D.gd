extends Camera2D

func _ready():
	Events.room_entered.connect(func(room):
		limit_top		= room.global_position.y
		limit_bottom	= room.global_position.y + 720
		limit_left		= room.global_position.x
		limit_right		= room.global_position.x + 1280
	)
