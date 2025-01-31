extends Control



func _ready():
	$"../CanvasLayer/Panel/VBoxContainer/Master Vol".value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$"../CanvasLayer/Panel/VBoxContainer/SFX Vol".value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$"../CanvasLayer/Panel/VBoxContainer/Music Vol".value = db_to_linear(AudioServer.get_bus_volume_db(2))
func _on_master_vol_mouse_exited():
	release_focus()

func _on_sfx_vol_mouse_exited():
	release_focus()

func _on_music_vol_mouse_exited():
	release_focus()
