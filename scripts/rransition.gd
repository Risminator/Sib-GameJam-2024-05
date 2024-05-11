extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.room_left.connect(_on_room_left)
	
func _on_room_left():
	play("fade_in")
