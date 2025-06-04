extends CharacterBody3D
class_name Bullet
@onready var timer = $Timer
var SPEED =30



func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	position+=transform.basis * Vector3(0,-SPEED,0)
	move_and_slide()


func _on_bullet_hibox_body_entered(body: Node3D) -> void:
	timer.start()





func _on_timer_timeout() -> void:
	queue_free()
