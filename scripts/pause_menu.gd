extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var btn_resume: Button = $PanelContainer/VBoxContainer/BtnResume
@onready var btn_restart: Button = $PanelContainer/VBoxContainer/BtnRestart
@onready var btn_main: Button = $PanelContainer/VBoxContainer/BtnMain
@export var track_esc: bool = true

@onready var music_scroll: HScrollBar = $PanelContainer/VBoxContainer/Music2
@onready var sound_scroll: HScrollBar = $PanelContainer/VBoxContainer/Sound2
@onready var env_scroll: HScrollBar = $PanelContainer/VBoxContainer/Environment2

func _ready():
	animation_player.play("RESET")
	music_scroll.value = Global.MusicVolume
	sound_scroll.value = Global.SoundEffectsVolume
	env_scroll.value = Global.EnemySoundsVolume

func resume():
	get_tree().paused = false
	visible = false
	deactivate_buttons()
	animation_player.play_backwards("blur")

func restart():
	resume()
	get_tree().reload_current_scene()

func pause():
	get_tree().paused = true
	visible = true
	activate_buttons()
	animation_player.play("blur")

func testEsc():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()

func activate_buttons():
	btn_resume.disabled = false
	btn_restart.disabled = false
	btn_main.disabled = false

func deactivate_buttons():
	btn_resume.disabled = true
	btn_restart.disabled = true
	btn_main.disabled = true

func _on_btn_resume_pressed():
	resume()

func _on_btn_restart_pressed():
	restart()

func _on_btn_main_pressed():
	resume()
	Global.set_scene(Global.SCENES.MAIN)

func _process(_delta):
	if track_esc:
		testEsc()


func _on_music_2_value_changed(value):
	Global.MusicVolume = value
	Events.volume_changed.emit()


func _on_sound_2_value_changed(value):
	Global.SoundEffectsVolume = value
	Events.volume_changed.emit()


func _on_environment_2_value_changed(value):
	Global.EnemySoundsVolume = value
	Events.volume_changed.emit()
