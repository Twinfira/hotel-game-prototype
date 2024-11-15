extends CharacterBody3D

const SPEED := 5.0
const JUMP_VELOCITY := 4.5
const CAM_CLAMP_MIN: int = 60 	# Degrees
const CAM_CLAMP_MAX: int = -60 # Degrees

var angular_accel: int = 8 # Controls how fast the smooth rotation of the player happens (used in lerp function)

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.025
@export var joystick_sensitivity := 2.0

@onready var camera_pivot: Node3D = %camera_pivot
@onready var visuals: Node3D = %visuals

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void: # _input will be called *BEFORE* GUI stuff
	# Handle mouse capture mode
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void: # _unhandled_input will be called *AFTER* GUI stuff
	# Mouse Camera Movement
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity
			camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(CAM_CLAMP_MAX), deg_to_rad(CAM_CLAMP_MIN))
			camera_pivot.rotation.y -= event.relative.x * mouse_sensitivity

func _physics_process(delta: float) -> void:
	# Gamepad Camera Movement
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var axis_vector := Vector2.ZERO
		axis_vector.x = Input.get_axis("cam_right", "cam_left") # -> Input.get_vector() ? 
		axis_vector.y = Input.get_axis("cam_down", "cam_up")	# ^ ^ ^ 
		camera_pivot.rotate_y(deg_to_rad(axis_vector.x * joystick_sensitivity))
		camera_pivot.rotation_degrees.x += axis_vector.y * joystick_sensitivity
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(CAM_CLAMP_MAX), deg_to_rad(CAM_CLAMP_MIN))
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	direction = direction.rotated(Vector3.UP, camera_pivot.global_transform.basis.get_euler().y).normalized()
	if direction:
		visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-direction.x, -direction.z), delta * angular_accel) # Interpolate for smooth rotation
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
