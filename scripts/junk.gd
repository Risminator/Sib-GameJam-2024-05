@tool

extends RigidBody2D

@export var texture: CompressedTexture2D
@export_range (0, 500, 1, "or_greater") var max_linear_velocity_length: float = 50
@export_range (0, 360, 1, "or_greater") var max_angular_velocity: float = 5
@onready var sprite = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = texture
	var shape: RectangleShape2D = RectangleShape2D.new()
	shape.size = Vector2(texture.get_width(), texture.get_height())
	collision_shape.shape = shape
	
func _integrate_forces(_state):
	linear_velocity = linear_velocity.limit_length(max_linear_velocity_length)
	angular_velocity = clampf(angular_velocity, -max_angular_velocity, max_angular_velocity)
