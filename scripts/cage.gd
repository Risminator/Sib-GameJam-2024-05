extends Area2D

@onready var door: Door = $DoorCage

var enemies_in_cage: Array[BigEnemy]

func trap_enemies():
	for enemy in enemies_in_cage:
		if !enemy.is_trapped:
			enemy.is_trapped = true
			Events.enemy_trapped.emit()

func _on_body_entered(body):
	if body is BigEnemy:
		body.is_in_cage = true
		enemies_in_cage.append(body)


func _on_body_exited(body):
	if body is BigEnemy:
		body.is_in_cage = false
		body.is_trapped = false
		enemies_in_cage.erase(body)


func _on_door_cage_door_closed():
	trap_enemies()
