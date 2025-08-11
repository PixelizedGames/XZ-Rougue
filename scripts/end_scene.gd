extends Node2D
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	$AnimatedSprite2D.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.visible = false


func _on_timer_2_timeout() -> void:
	get_tree().quit()
