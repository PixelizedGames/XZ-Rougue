extends Node3D
@onready var timer = $Timer
@onready var box = preload("res://objects/moveable_box.tscn")
@onready var sphere = preload("res://objects/moveable_sphere.tscn")
func _ready():
	spawn_obj_b()
	spawn_obj_s()
	timer.start()

func spawn_obj_b():
	var spawnx = randf_range(1, 50)
	var spawnz = randf_range(-8, 8)
	var instance = box.instantiate()
	var new_transform = Transform3D() 
	new_transform.origin = Vector3(spawnx, 1, spawnz)  
	instance.global_transform = new_transform
	get_tree().current_scene.add_child(instance)
	
func spawn_obj_s():
	var spawnx = randf_range(1, 50)
	var spawnz = randf_range(-8, 8)
	var instance = sphere.instantiate()
	var new_transform = Transform3D()  
	new_transform.origin = Vector3(spawnx, 1, spawnz)  
	instance.global_transform = new_transform
	get_tree().current_scene.add_child(instance)

func _on_timer_timeout():
	timer.start()
	spawn_obj_b()
	spawn_obj_s()
