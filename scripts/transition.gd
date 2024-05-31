extends ColorRect
class_name Transition

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_in():
	animation_player.play("fade_in")

func end_fade_in():
	animation_player.play("end_fade_in")

func fade_out():
	animation_player.play("fade_out")
	
func fade_transition(fun: Callable):
	fade_in()
	fun.call()
	fade_out.call_deferred()

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.room_left.connect(_on_room_left)
	
func _on_room_left():
	fade_in()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in" or anim_name == "end_fade_in":
		Events.fade_in_finished.emit()
