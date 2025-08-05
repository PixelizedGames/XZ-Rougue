extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://level/main_level.tscn")
	GlobalVariables.menu = false
	


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://level/tutorial.tscn")
