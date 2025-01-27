extends Area2D

@onready var tile_map: TileMap = $".."
var acjesent=true
var wall_tile := Vector2i(15, 5)



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("door"):
		
		acjesent=false
		queue_free()


func _ready() -> void:
	$"Timer".start()
	await $"Timer".timeout
	if acjesent:
		print("uu")
		var tile_position = Vector2i(0,0) # Convert global_position to Vector2i
		tile_position = Vector2i(-11,-13)
		for i in range(3):
			tile_map.set_cell(0, tile_position, 1, wall_tile) # Ensure the layer, position, tile ID, and autotile coordinates are correct
			tile_position += Vector2i(0, 1)
			queue_free()