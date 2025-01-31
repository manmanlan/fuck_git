extends Control

@onready var pause_menu = $Pausemenu
# Variable to store the path of the previous scene
var previous_scene = ""

signal back_pressed  # Define a signal for when the back button is pressed

# Function to set the previous scene path before navigating to the settings menu
func set_previous_scene(scene_path):
	previous_scene = scene_path


func _on_back_pressed():
	emit_signal("back_pressed") 
	self.hide()  
	AudioServer.set_bus_volume_db(0, linear_to_db($"CanvasLayer/Panel/VBoxContainer/Master Vol".value))
	AudioServer.set_bus_volume_db(1, linear_to_db($"CanvasLayer/Panel/VBoxContainer/SFX Vol".value))
	AudioServer.set_bus_volume_db(2, linear_to_db($"CanvasLayer/Panel/VBoxContainer/Music Vol".value))
	queue_free()
