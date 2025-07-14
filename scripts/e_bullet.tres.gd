extends CharacterBody3D
class_name ebullet

const SPEED = 1.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	position+=transform.basis * Vector3(0,-SPEED,0)
	move_and_slide()
