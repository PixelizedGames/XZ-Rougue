extends Node2D
var textmove = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if textmove == true:
		position.y -= 50 * delta


func _on_timer_timeout() -> void:
	textmove = true
