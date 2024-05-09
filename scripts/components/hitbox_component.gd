extends Area2D

@export var health_component: HealthComponent

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)


func _on_area_entered(area):
	get_parent().queue_free()
