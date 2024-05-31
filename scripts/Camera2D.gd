extends Camera2D

@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func _ready():
	Events.screen_shake.connect(_on_screen_shake)

func apply_shake(strength):
	shake_strength = strength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		offset = randomOffset()


func _on_screen_shake(strength):
	apply_shake(strength)
