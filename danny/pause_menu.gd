extends Control

# Reference to the PauseMenu CanvasLayer
@onready var pause_menu = $PauseMenu
@onready var color_rect = $PauseMenu/ColorRect  # Reference to ColorRect for shading

# Track the paused state
var is_paused = false

# Handle input for toggling pause
func _input(event):
	if event.is_action_pressed("esc"):  # "ui_cancel" maps to Esc by default
		toggle_pause()

# Function to toggle pause state
func toggle_pause():
	is_paused = not is_paused
	get_tree().paused = is_paused  # Pause or resume the game engine
	pause_menu.visible = is_paused  # Show or hide the pause menu
	color_rect.visible = is_paused  # Enable or disable dimmed background

func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	toggle_pause()
