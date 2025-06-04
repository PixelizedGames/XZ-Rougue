extends CharacterBody3D
@onready var timer = $Timer
var SPEED = 10



func _physics_process(delta: float) -> void:
	position+=transform.basis * Vector3(0,-SPEED,0)
	move_and_slide()

func _ready():
	timer.start()





func _on_timer_timeout() -> void:
	queue_free()
