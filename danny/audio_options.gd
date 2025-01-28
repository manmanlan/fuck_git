extends Control



func _ready():
	$"MarginContainer/VBoxContainer/Master Vol".value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$"MarginContainer/VBoxContainer/SFX Vol".value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$"MarginContainer/VBoxContainer/Music Vol".value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_master_vol_mouse_exited():
	release_focus()

func _on_sfx_vol_mouse_exited():
	release_focus()

func _on_music_vol_mouse_exited():
	release_focus()
