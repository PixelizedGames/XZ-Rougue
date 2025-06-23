extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var player = $"../player"

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta


	# Face the player
	look_at(player.global_transform.origin, Vector3.UP)

	# Move forward in the facing direction
	var direction = -transform.basis.z  # Forward vector
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()
