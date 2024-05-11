extends Node


func start_game():
	Global.set_scene(Global.SCENES.CUTSCENE)
	
func quit_game():
	get_tree().quit()

func _on_start_btn_pressed():
	start_game.call_deferred()


func _on_how_to_btn_pressed():
	pass # Replace with function body.


func _on_options_btn_pressed():
	pass # Replace with function body.


func _on_quit_btn_pressed():
	quit_game.call_deferred()
