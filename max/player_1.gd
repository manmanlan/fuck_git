extends CharacterBody2D

# Constants for movement
const SPEED: float = 100.0
const ACCEL: float = 10.0
const ANIMATION_SPEED: int = 6  # Frames per second for walking animations

# Frame size (will be set dynamically)
var FRAME_WIDTH: int = 64
var FRAME_HEIGHT: int = 64

# Node references
@onready var sprite: Sprite2D = $Sprite2D  # Character body sprite
@onready var hat1_sprite: Sprite2D = $Hat1 # Hat sprite (layer)
@onready var box_sprite: Sprite2D = $Box   # Box sprite (layer)

# Variables for input, animations, and direction
var input: Vector2
var animation_timer: float = 0.0
var facing_direction: int = 0  # 0: Down, 1: Up, 2: Right, 3: Left
var is_moving: bool = false  # Movement flag

func _ready() -> void:
	# Ensure the sprites and textures are properly set up
	if not sprite or not sprite.texture:
		print("Error: Character body sprite or texture not set!")
		return
	if not hat1_sprite or not hat1_sprite.texture:
		print("Error: Hat sprite or texture not set!")
		return
	if not box_sprite or not box_sprite.texture:
		print("Error: Box sprite or texture not set!")
		return

	# Dynamically calculate frame size based on the texture
	FRAME_WIDTH = sprite.texture.get_width() / 8
	FRAME_HEIGHT = sprite.texture.get_height() / 8

	# Enable sprite regions for animations
	sprite.region_enabled = true
	sprite.region_rect = Rect2(Vector2.ZERO, Vector2(FRAME_WIDTH, FRAME_HEIGHT))

	hat1_sprite.region_enabled = true
	hat1_sprite.region_rect = Rect2(Vector2.ZERO, Vector2(FRAME_WIDTH, FRAME_HEIGHT))

	box_sprite.region_enabled = true
	box_sprite.region_rect = Rect2(Vector2.ZERO, Vector2(FRAME_WIDTH, FRAME_HEIGHT))

	print("Character and layered sprites are ready!")

func get_input() -> Vector2:
	# Capture movement input (WASD controls)
	input.x = Input.get_action_strength("w") - Input.get_action_strength("s")
	input.y = Input.get_action_strength("d") - Input.get_action_strength("a")
	return input.normalized()

func _process(delta: float) -> void:
	# Update the sprite based on mouse direction and movement
	update_sprite(delta)
	update_layered_sprites(delta)

func _physics_process(delta: float) -> void:
	# Handle movement
	var player_input = get_input()

	# Get the direction to the mouse
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()

	# Get the angle between the player and the mouse
	var angle = direction.angle()

	# Rotate the input vector based on the mouse angle (no inversion)
	var rotated_input = player_input.rotated(angle)

	# Apply the movement based on rotated input
	velocity = lerp(velocity, rotated_input * SPEED, delta * ACCEL)
	move_and_slide()

	# Update movement status (used to control walking animation)
	is_moving = velocity.length() > 0.1  # Ensure the character is truly moving

func update_sprite(delta: float) -> void:
	# Get the direction to the mouse
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()

	# Determine the facing direction based on the mouse position
	if abs(direction.x) > abs(direction.y):
		facing_direction = 2 if direction.x > 0 else 3  # Right or Left
	else:
		facing_direction = 0 if direction.y > 0 else 1  # Down or Up

	# Determine the animation frame
	var frame_x: int = 0
	if is_moving:
		animation_timer += delta * ANIMATION_SPEED
		frame_x = int(animation_timer) % 6  # Cycle through walking frames
	else:
		animation_timer = 0
		frame_x = 0  # Immediately switch to standing frame when not moving

	# Calculate the Y offset based on direction
	var frame_y = facing_direction
	if is_moving:
		if facing_direction == 0:  # Walking Down
			frame_y = 4
		elif facing_direction == 1:  # Walking Up
			frame_y = 5
		elif facing_direction == 2:  # Walking Right
			frame_y = 6
		elif facing_direction == 3:  # Walking Left
			frame_y = 7

	# Safely update the sprite's region
	if sprite.texture:
		var texture_size = sprite.texture.get_size()
		if frame_x * FRAME_WIDTH < texture_size.x and frame_y * FRAME_HEIGHT < texture_size.y:
			sprite.region_rect = Rect2(Vector2(frame_x * FRAME_WIDTH, frame_y * FRAME_HEIGHT), Vector2(FRAME_WIDTH, FRAME_HEIGHT))
		else:
			print("Warning: region_rect out of bounds")

func update_layered_sprites(delta: float) -> void:
	# Update the hat and box sprites (Layered Sprites)
	var is_moving = velocity.length() > 0
	var frame_x: int = 0
	if is_moving:
		animation_timer += delta * ANIMATION_SPEED
		frame_x = int(animation_timer) % 6  # Cycle through walking frames
	else:
		animation_timer = 0
		frame_x = 0

	# Update the region for hat1_sprite (positioned on top of the character)
	if hat1_sprite.texture:
		hat1_sprite.region_rect = Rect2(Vector2(frame_x * FRAME_WIDTH, facing_direction * FRAME_HEIGHT), Vector2(FRAME_WIDTH, FRAME_HEIGHT))

	# Update the region for box_sprite (positioned on top of the character)
	if box_sprite.texture:
		box_sprite.region_rect = Rect2(Vector2(frame_x * FRAME_WIDTH, facing_direction * FRAME_HEIGHT), Vector2(FRAME_WIDTH, FRAME_HEIGHT))
