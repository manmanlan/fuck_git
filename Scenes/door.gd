extends Area2D




const DUNGEON_ROOMS_PRESET = preload("res://danny/Dungeon Rooms Preset.tscn")
var v1 = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.position.x -= 40
		if v1:
			spawn(Vector2(379, 8))
			v1 = false

func spawn(spawn_position: Vector2) -> void:
	var ROOM_2_temp = DUNGEON_ROOMS_PRESET.instantiate()
	add_child(ROOM_2_temp)
	ROOM_2_temp.position = spawn_position
