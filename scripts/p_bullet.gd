extends CharacterBody3D
class_name PBullet
@onready var timer = $Timer
@onready var timer2 = $Timer2
@onready var timer3 = $Timer3
var SPEED = 7

func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	pass

func _ready():
	timer.start()
	timer2.start()





func _on_timer_timeout() -> void:
	queue_free()


func _on_timer_2_timeout() -> void:
	timer2.start()
	position+=transform.basis * Vector3(0,-SPEED,0)
	move_and_slide()


func _on_bullet_area_body_entered(body):
	if body is enemy:
		timer3.start()


func _on_timer_3_timeout():
	queue_free()
