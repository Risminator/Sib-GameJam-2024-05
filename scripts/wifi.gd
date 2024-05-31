extends GPUParticles2D


func _ready():
	Events.victory.connect(_on_victory)

func _on_victory():
	visible = true
