extends MeshInstance3D

@onready var timer = $Timer
var light_is_on = true

func _ready():
	if GlobalVariables.lights:
		start_random_light_cycle()
	else:
		turn_off_light()

func start_random_light_cycle():
	if GlobalVariables.lights:
		var wait = 0.5
		if light_is_on:
			wait = randf_range(1.0, 10.0)
		timer.start(wait)

func _on_timer_timeout():
	if GlobalVariables.lights:
		light_is_on = !light_is_on
		if light_is_on:
			$SpotLight3D.light_energy = 10.0
		else:
			$SpotLight3D.light_energy = 0.0
		start_random_light_cycle()
	else:
		turn_off_light()

func turn_off_light():
	timer.stop()
	light_is_on = false
	$SpotLight3D.light_energy = 0.0
