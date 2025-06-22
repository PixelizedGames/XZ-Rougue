extends Node3D

@onready var timer = $Timer
@onready var timer2 = $Timer2
@onready var box = preload("res://objects/moveable_box.tscn")
@onready var sphere = preload("res://objects/moveable_sphere.tscn")
@onready var world_environment = $WorldEnvironment

var fog_height: float = 1.0  # Starting fog height

func _ready():
	spawn_obj_b()
	spawn_obj_s()
	timer.start()
	timer2.start()

func spawn_obj_b():
	var spawnx = randf_range(1, 50)
	var spawnz = randf_range(-8, 8)
	var instance = box.instantiate()
	instance.global_transform.origin = Vector3(spawnx, 1, spawnz)
	get_tree().current_scene.add_child(instance)

func spawn_obj_s():
	var spawnx = randf_range(1, 50)
	var spawnz = randf_range(-8, 8)
	var instance = sphere.instantiate()
	instance.global_transform.origin = Vector3(spawnx, 1, spawnz)
	get_tree().current_scene.add_child(instance)

func _on_timer_timeout():
	timer.start()
	spawn_obj_b()
	spawn_obj_s()

func _on_timer2_timeout():
	timer2.start()
	fog_height += 0.5
	var env = world_environment.environment
	env.fog_height = fog_height
