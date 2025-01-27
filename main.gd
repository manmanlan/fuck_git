extends Node2D

# Reference to the PauseMenu CanvasLayer
@onready var pause_menu = $PauseMenu
@onready var color_rect = $PauseMenu/ColorRect  # Reference to ColorRect for shading

# Track the paused state
var is_paused = false

# Handle input for toggling pause
func _input(event):
	if event.is_action_pressed("esc"):  # Detect input for "esc"
		toggle_pause()

# Function to toggle pause state
func toggle_pause():
	# Toggle the paused state
	is_paused = not is_paused
	get_tree().paused = is_paused  # Pauses or resumes the game engine

	# Debug messages for clarity
	if is_paused:
		print("Game paused")  # Debug message for pause
	else:
		print("Game resumed")  # Debug message for resume

	# Toggle the visibility of the pause menu and dim background
	pause_menu.visible = is_paused
	color_rect.visible = is_paused


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://danny/Settings_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
