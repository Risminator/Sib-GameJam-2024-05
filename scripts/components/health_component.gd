extends Node2D
class_name HealthComponent
signal health_updated(new_value)

@export var MAX_HEALTH: int = 1:
	set(new_max):
		MAX_HEALTH = new_max
		health = clamp(health, 0, new_max)
@export var health: int = MAX_HEALTH:
	set(new_health):
		health = clamp(new_health, 0, MAX_HEALTH)
		print(MAX_HEALTH)
		print(health)
		health_updated.emit(health)
	get:
		return health


func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		get_parent().queue_free()
