extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.visible = true
	$AnimatedSprite2D.play("begin")
	await get_tree().create_timer(2).timeout
	$Label.visible = false
	$AnimatedSprite2D.play("movie")
	await get_tree().create_timer(7).timeout
	$AnimatedSprite2D.play("end")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		get_tree().change_scene_to_file("res://level/start.tscn")
