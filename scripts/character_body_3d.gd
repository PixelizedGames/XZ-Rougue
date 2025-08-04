extends CharacterBody3D
class_name player
var vertical_look_angle = 0.0
var SPEED = 9
var PSReady = true
var SPEEDY = 0
var hack_g = 1
var hack_s = 1
var health = 100
var imunity = false
var fullscreen = true
const JUMP_VELOCITY = 5.0
const MAX_LOOK_ANGLE = 90.0
const MIN_LOOK_ANGLE = -90.0
@onready var MOUSE_SENSITIVITY = 0.1
@onready var bullet_scene = preload("res://objects/p_bullet.tscn")
@onready var PSTimer = $PSTimer
@onready var Imunity_timer = $ITimer
@onready var animation = $enemy_godot/AnimationPlayer

func _ready() -> void:
	$Menu.visible = false
	$Menu/MainMenu.visible = false
	$Menu/Settings.visible = false
	$Menu/Controlls.visible = false
	$Menu/Accsesibility.visible = false
	$"Menu/Video settings".visible = false
func _physics_process(delta: float) -> void:
	if $Menu.visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		GlobalVariables.menu = true
	if $Menu.visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		GlobalVariables.menu = false
		
	MOUSE_SENSITIVITY = ($"Menu/Accsesibility/Mouse slider".value / 1000)
	if Input.is_action_pressed("hack"):
		hack_g = 0.1
		hack_s = 3
	else:
		hack_g = 1.3
		hack_s = 1
	if Input.is_action_pressed("shoot"):
		_spawn_bullet()
	if Input.is_action_pressed("ctrl"):
		SPEED = 2
		$CollisionShape3D.scale = Vector3(1,0.6,1)
	else:
		SPEED = 9 
		$CollisionShape3D.scale = Vector3(1,1,1)
	if Input.is_action_pressed("s") or Input.is_action_pressed("a") or Input.is_action_pressed("w") or Input.is_action_pressed("d") and GlobalVariables.menu == false:
		if SPEED == 9 and not $AudioStreamPlayer3D.playing:
			$AudioStreamPlayer3D.play()
			GlobalVariables.run_audio = true
			animation.play("running")
			animation.speed_scale = 8
		if SPEED == 2 and not $AudioStreamPlayer3D2.playing:
			$AudioStreamPlayer3D2.play()
			GlobalVariables.walk_audio = true
			animation.play("walking")
			animation.speed_scale = 2.8
	else:
		$AudioStreamPlayer3D.stop()
		$AudioStreamPlayer3D2.stop()
		GlobalVariables.run_audio = false
		GlobalVariables.walk_audio = false
		animation.stop()
	if Input.is_action_pressed("aim") and GlobalVariables.menu == false:
		$Camera3D.fov = 45
	else:
		$Camera3D.fov = 90
	if not is_on_floor():
		$AudioStreamPlayer3D.stop()
		$AudioStreamPlayer3D2.stop()
		GlobalVariables.run_audio = false
		GlobalVariables.walk_audio = false
	if not is_on_floor() and GlobalVariables.menu == false:
		velocity += get_gravity() * hack_g * delta 
		SPEEDY = 2
	if is_on_floor():
		SPEEDY = 0
	if Input.is_action_just_pressed("jump") and is_on_floor() and GlobalVariables.menu == false:
		velocity.y = JUMP_VELOCITY
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * (SPEED + (SPEEDY * hack_s))
		velocity.z = direction.z * (SPEED + (SPEEDY * hack_s))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if GlobalVariables.menu == false:
		move_and_slide()
	if health <= 0:
		get_tree().change_scene_to_file("res://level/start.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and GlobalVariables.menu == false:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		vertical_look_angle = clamp(vertical_look_angle - event.relative.y * MOUSE_SENSITIVITY, MIN_LOOK_ANGLE, MAX_LOOK_ANGLE)
		$Camera3D.rotation_degrees.x = vertical_look_angle
		$pistol.rotation_degrees.x = -vertical_look_angle

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") and GlobalVariables.menu == false:
		$Menu.visible = true
		$Menu/MainMenu.visible = true
		$Menu/MainMenu.visible = true
		$Menu/Settings.visible = false
		$Menu/Controlls.visible = false
		$Menu/Accsesibility.visible = false
		$"Menu/Video settings".visible = false
		
		

func _spawn_bullet():
	if PSReady == true and GlobalVariables.menu == false:
		PSReady = false
		PSTimer.start()
		var instance = bullet_scene.instantiate()
		instance.global_transform = $pistol/spawning_pos.global_transform
		get_parent().add_child(instance)
		$gun_shot.play()
		GlobalVariables.shot_audio = true


func _on_ps_timer_timeout():
	PSReady = true
	GlobalVariables.shot_audio = false


func _on_area_3d_body_entered(body) :
	if body is ebullet and imunity == false and GlobalVariables.menu == false:
		imunity = true
		health -= 40
		Imunity_timer.start()


func _on_timer_timeout() -> void:
	imunity = false
	
func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://level/start.tscn")

func _on_settings_pressed() -> void:
	$Menu/MainMenu.visible = false
	$Menu/Settings.visible = true
	

func _on_controlls_pressed():
	$Menu/Controlls.visible = true
	$Menu/Settings.visible = false

func _on_accsesability_pressed():
	$Menu/Accsesibility.visible = true
	$Menu/Settings.visible = false

func _on_video_settings_pressed():
	$"Menu/Video settings".visible = true
	$Menu/Settings.visible = false

func _on_back_pressed():
	$Menu/MainMenu.visible = true
	$Menu/Settings.visible = false
	$Menu/Controlls.visible = false
	$Menu/Accsesibility.visible = false
	$"Menu/Video settings".visible = false

func _on_resume_pressed():
	$Menu.visible = false

func _on_flickering_lights_pressed():
	if(GlobalVariables.lights == false):
		GlobalVariables.lights = true
		print("Light On")
	else:
		GlobalVariables.lights = false
		print("Light Off")

func _on_fullscreen_pressed():
	if fullscreen == true:
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$"Menu/Video settings/Fullscreen".text = "Windowed"
	else:
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$"Menu/Video settings/Fullscreen".text = "Fullscreen"
