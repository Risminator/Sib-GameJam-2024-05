extends Node

@onready var btn_quit: Button = $QuitBtn
@onready var pause: Control = $CanvasLayer/PauseMenu

func _ready():
	if OS.has_feature("web"):
		btn_quit.clip_contents = true
		btn_quit.disabled = true
		btn_quit.visible = false
	pause.btn_main.disabled = true
	pause.btn_main.visible = false
	pause.btn_restart.disabled = true
	pause.btn_restart.visible = false
	pause.visible = false
	pause.track_esc = false

func start_game():
	Global.set_scene(Global.SCENES.CUTSCENE)
	
func quit_game():
	get_tree().quit()

func _on_start_btn_pressed():
	start_game.call_deferred()


func _on_options_btn_pressed():
	pause.visible = true
	pause.pause()


func _on_quit_btn_pressed():
	quit_game.call_deferred()
