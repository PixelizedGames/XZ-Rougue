extends CharacterBody3D
class_name enemy
var imunity = false
var health = 10
var shoot_avalible = true
var inrange = false
var audio_range1 = false
var audio_range2 = false
var targetable = false
var SPEED = 2
const JUMP_VELOCITY = 4.5
@onready var timer = $Timer
@onready var delay_timer = $shoot_delay
@onready var player = $"../player"
@onready var bullet_scene = preload("res://objects/e_bullet.tscn")
@onready var spawn_pos = $pistol/spawn_pos
@onready var audio = $audio
@onready var animation = $enemy_godot/AnimationPlayer

func _ready() -> void:
	SPEED = 2
	animation.play("walking")
	audio.start()
func _physics_process(delta):
	if inrange == true:
		await get_tree().create_timer(1).timeout
		shoot()
		
	if health <=0:
		queue_free()
	
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		
	if targetable == true or inrange == true:
		look_at(player.global_transform.origin, Vector3.UP)
		SPEED = 5
		animation.play("running")
		animation.speed_scale = 9
		$AudioStreamPlayer3D.play()
	else:
		SPEED = 1.5
		animation.play("walking")
		animation.speed_scale = 3
		$AudioStreamPlayer3D2.play()
	var direction = -transform.basis.z 
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	move_and_slide()
	
	if audio_range1 and GlobalVariables.run_audio:
		targetable = true
	elif audio_range1 and GlobalVariables.shot_audio:
		targetable = true
	elif audio_range2 and GlobalVariables.walk_audio:
		targetable = true
	else:
		targetable = false


func _on_enemy_body_entered(body):
	if body is PBullet and imunity == false:
		look_at(player.global_transform.origin, Vector3.UP)
		timer.start()
		health -= 3

func _on_timer_timeout():
	imunity = false
	
func shoot():
	if shoot_avalible == true:
		shoot_avalible = false
		delay_timer.start()
		var instance = bullet_scene.instantiate()
		instance.global_transform = spawn_pos.global_transform
		get_parent().add_child(instance)

func _on_shot_area_body_entered(body: Node3D) -> void:
	if body is player:
		inrange = true
func _on_shoot_delay_timeout() -> void:
	shoot_avalible = true
func _on_shot_area_body_exited(body: Node3D) -> void:
	if body is player:
		inrange = false

func _on_audio_timeout() -> void:
	$AudioStreamPlayer3D.play()
	audio.start()


func _on_loud_audio_body_entered(body: Node3D) -> void:
	if body is player:
		audio_range1 = true
func _on_loud_audio_body_exited(body: Node3D) -> void:
	if body is player:
		audio_range1 = false
func _on_quiet_audio_body_entered(body: Node3D) -> void:
	if body is player:
		audio_range2 = true
func _on_quiet_audio_body_exited(body: Node3D) -> void:
	if body is player:
		audio_range2 = false


func _on_turn_timeout() -> void:
	rotation.y += deg_to_rad(180)
	$turn.start()


func _on_enemy__head_hitbox_2_body_entered(body: Node3D) -> void:
	if body is PBullet and imunity == false:
		look_at(player.global_transform.origin, Vector3.UP)
		timer.start()
		health -= 10
