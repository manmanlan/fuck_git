extends CanvasLayer

@onready var healthbar = $Healthbar

var max_health = 8  # Maximum health (can be adjusted if needed)

func _process(delta):
	healthbar.frame = clamp(Global.player_hp, 0, max_health)
