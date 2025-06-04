extends Node3D

@export var speed: float = 1
var direction: Vector3

func _ready() -> void:
	# Save the initial forward direction (-Z in local space)
	direction = -global_transform.basis.z

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
