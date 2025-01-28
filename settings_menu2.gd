extends Control

# Variable to store the path of the previous scene
var previous_scene = ""

# Function to set the previous scene path before navigating to the settings menu
func set_previous_scene(scene_path):
	previous_scene = scene_path

# Function for the back button to return to the previous scene
func _on_back_pressed():
	AudioServer.set_bus_volume_db(0, linear_to_db($"AudioOptions/MarginContainer/VBoxContainer/Master Vol".value))
	AudioServer.set_bus_volume_db(1, linear_to_db($"AudioOptions/MarginContainer/VBoxContainer/SFX Vol".value))
	AudioServer.set_bus_volume_db(2, linear_to_db($"AudioOptions/MarginContainer/VBoxContainer/Music Vol".value))
	queue_free()
