extends MeshInstance3D

@onready var timer = $Timer
var light_is_on = true

func _ready():
	start_random_light_cycle()

func start_random_light_cycle():
	if light_is_on:
		var wait = randf_range(1.0, 10.0)
		timer.start(wait)
	else:
		var wait = 0.5
		timer.start(wait)

func _on_timer_timeout():
	light_is_on = !light_is_on

	if light_is_on:
		$SpotLight3D.light_energy = 2.0
	else:
		$SpotLight3D.light_energy = 0.0
	start_random_light_cycle()
