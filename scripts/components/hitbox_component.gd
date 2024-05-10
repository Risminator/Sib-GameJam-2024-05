extends Area2D
class_name HitboxComponent
@export var health_component: HealthComponent
@export var invincibility_time = 3

@onready var character: CharacterBody2D = get_parent()
@onready var timer: Timer = $Timer
@onready var old_collision_layer: int = collision_layer

func _ready():
	timer.wait_time = invincibility_time

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
	character.velocity = (global_position - attack.attack_position).normalized() * attack.knockback_force
	get_invincible()
	
func get_invincible():
	collision_layer = 0
	character.modulate.a = 0.5
	timer.start()
	print("Collision!", collision_layer)

func _on_timer_timeout():
	collision_layer = old_collision_layer
	character.modulate.a = 1
	print("Time's up", collision_layer)
