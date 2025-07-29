extends CharacterBody3D
class_name PBullet
@onready var timer = $Timer
@onready var timer2 = $Timer2
@onready var timer3 = $Timer3
var SPEED = 1



func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	position+=transform.basis * Vector3(0,-SPEED,0)
	move_and_slide()

func _ready():
	timer.start()
	timer2.start()
func _on_timer_timeout() -> void:
	queue_free()

func _on_bullet_area_body_entered(body):
	if body is enemy:
		timer3.start()


func _on_timer_3_timeout():
	queue_free()


func _on_bullet_area_area_entered(area: Area3D) -> void:
	timer3.start()
