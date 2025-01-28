extends Control

# Reference to the PauseMenu CanvasLayer
@onready var pause_menu = $PauseMenu
@onready var color_rect = $PauseMenu/ColorRect  # Reference to ColorRect for shading
const SETTINGS_MENU = preload("res://settings_menu2.tscn")
var spawn_position=Vector2(0,0)

func resume():
	get_tree().paused = false
	pause_menu.visible = false

func pause():
	get_tree().paused = true
	pause_menu.visible = true

func Testesc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _process(delta):
	Testesc()

func _on_resume_pressed():
	resume()

func _on_settings_p_pressed():
	resume()
	if get_tree().current_scene:  # Ensure the current scene is valid
		var SETTINGS_MENU_temp = SETTINGS_MENU.instantiate()

		add_child(SETTINGS_MENU_temp)

		SETTINGS_MENU_temp.position = spawn_position
	else:
		print("No current scene is loaded.")

func _on_return_to_main_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://danny/main_menu.tscn")
	
