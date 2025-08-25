extends CharacterBody3D
class_name ebullet

const SPEED = 1.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	if GlobalVariables.menu == false:
		position+=transform.basis * Vector3(0,-SPEED,0)
		move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_3d_area_entered(area):
	if area is box_area:
		queue_free()
