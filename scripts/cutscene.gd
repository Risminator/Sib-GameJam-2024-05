extends Node
class_name Cutscene

#@onready var cutscene_frame: Sprite2D = $Container/Frame
@onready var texture_rect: TextureRect = $TextureRect
@onready var transition: Transition = $CanvasLayer/Transition
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var frame = 0
var framesN: int

func _ready():
	audio_player.volume_db = Global.MusicVolume
	texture_rect.texture.region.position.x = frame * 640
	framesN = texture_rect.texture.atlas.get_width() / 640
	Events.volume_changed.connect(_on_volume_changed)

func _on_volume_changed():
	audio_player.volume_db = Global.MusicVolume
	
func _process(_delta):
	if Input.is_action_just_pressed("toggle_light") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		if frame == framesN - 1:
			transition.fade_in()
			await Events.fade_in_finished
			Global.set_level_scene("a")
		else:
			frame += 1
			texture_rect.texture.region.position.x = frame * 640
			match frame:
				1:
					Events.screen_shake.emit(20.0)
				3:
					Events.screen_shake.emit(5.0)
				7:
					Events.screen_shake.emit(5.0)
	if Input.is_action_just_pressed("backwards") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
		if frame > 0:
			frame -= 1
			texture_rect.texture.region.position.x = frame * 640
