extends Node2D

@onready var timer1 = $Timer_1
@onready var timer2 = $Timer_2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer1.start()
	$Label.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		get_tree().change_scene_to_file("res://level/start.tscn")


func _on_timer_1_timeout() -> void:
	$Label.visible = false
	$AnimatedSprite2D.play("movie")
	timer2.start()


func _on_timer_2_timeout() -> void:
	$AnimatedSprite2D.pause("movie")
