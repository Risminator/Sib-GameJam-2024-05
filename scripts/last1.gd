extends Node2D

@onready var trapped_label = $CanvasLayer/TrappedLabel
@onready var camera_transform: RemoteTransform2D = $Player/RemoteTransform2D
@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var transition: Transition = $CanvasLayer/Transition

var enemies_count: int
var enemies_trapped: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies_count = get_tree().get_nodes_in_group("enemies").size()
	trapped_label.text = "Поймано: " + str(enemies_trapped) + " / " + str(enemies_count)
	Events.enemy_trapped.connect(_on_enemy_trapped)
	Events.enemy_escaped.connect(_on_enemy_escaped)
	Events.victory.connect(_on_victory)

func _on_enemy_trapped():
	enemies_trapped += 1
	trapped_label.text = "Поймано: " + str(enemies_trapped) + " / " + str(enemies_count)
	if enemies_trapped == enemies_count:
		Events.victory.emit()

func _on_enemy_escaped():
	enemies_trapped -= 1
	trapped_label.text = "Поймано: " + str(enemies_trapped) + " / " + str(enemies_count)

func _on_victory():
	player.is_controllable = false
	camera_transform.update_position = false
	camera.limit_top = -1800
	var tween = create_tween()
	tween.tween_property(camera, "global_position", camera.global_position - Vector2(0, 500), 5)
	transition.end_fade_in()
	await Events.fade_in_finished
	win.call_deferred()
	
func win():
	Global.set_scene(Global.SCENES.ENDING)
