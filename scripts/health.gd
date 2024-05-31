extends TextureRect

var initial_health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.region.position.x = initial_health * 128
	Events.damage_taken.connect(_on_damage_taken)


func _on_damage_taken(health):
	texture.region.position.x = health * 128
