extends CharacterBody3D

var SPEED = 8.0
const JUMP_VELOCITY = 5.0
const MAX_LOOK_ANGLE = 90.0
const MIN_LOOK_ANGLE = -90.0
@onready var MOUSE_SENSITIVITY = 0.1
var vertical_look_angle = 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ctrl"):
		SPEED = 2
		scale = Vector3(1,0.6,1)
	else:
		SPEED = 8
		scale = Vector3(1,1,1)
	if not is_on_floor():
		velocity += get_gravity() * 1.4 * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		vertical_look_angle = clamp(vertical_look_angle - event.relative.y * MOUSE_SENSITIVITY, MIN_LOOK_ANGLE, MAX_LOOK_ANGLE)
		$Camera3D.rotation_degrees.x = vertical_look_angle

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Show mouse when exiting
		get_tree().quit()
