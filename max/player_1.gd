extends CharacterBody2D

# Constants for movement
const SPEED : float = 100.0
const ACCEL : float = 10.0

# Node references
@onready var sprite : Sprite2D = $Sprite2D  # Reference to the Sprite2D node

# Variables for input and animations
var input : Vector2
var is_running : bool = false

func _ready() -> void:
	# Ensure the sprite is visible and properly set up
	if not sprite or not sprite.texture:
		print("Error: Sprite or texture not set!")
		return
	sprite.region_enabled = true
	sprite.scale = Vector2(1, 1)
	print("Sprite texture size: ", sprite.texture.get_size())

func get_input() -> Vector2:
	# Capture movement input
	input.x = Input.get_action_strength("d") - Input.get_action_strength("a")
	input.y = Input.get_action_strength("s") - Input.get_action_strength("w")
	return input.normalized()

func _process(delta: float) -> void:
	# Update the sprite based on input and mouse
	update_sprite()

func _physics_process(delta: float) -> void:
	# Handle movement
	var player_input = get_input()
	velocity = lerp(velocity, player_input * SPEED, delta * ACCEL)
	move_and_slide()

func update_sprite() -> void:
	# Calculate direction to face the mouse
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()

	# Determine facing direction
	var frame_x = 0
	var frame_y = 0

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			frame_y = 2  # Facing right
		else:
			frame_y = 3  # Facing left
	else:
		if direction.y > 0:
			frame_y = 0  # Facing down
		else:
			frame_y = 1  # Facing up

	# Set animation frame based on movement
	if velocity.length() > 0:  # Moving
		frame_x = int(Time.get_ticks_msec() / 100) % 6  # Cycling animation frames
	else:  # Idle
		frame_x = 0

	# Update the sprite's region rect
	sprite.region_rect = Rect2(Vector2(frame_x * 64, frame_y * 64), Vector2(64, 64))
	print("Updated region rect: ", sprite.region_rect)
	
