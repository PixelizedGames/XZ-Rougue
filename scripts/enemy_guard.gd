extends CharacterBody3D
class_name enemy
var imunity = false
var health = 10
var shoot_avalible = true
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var timer = $Timer
@onready var delay_timer = $shoot_delay
@onready var player = $"../player"
@onready var bullet_scene = preload("res://objects/e_bullet.tscn")
@onready var spawn_pos = $spawn_pos

func _physics_process(delta):
	if health <=0:
		queue_free()
	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		
	look_at(player.global_transform.origin, Vector3.UP)

	# Move forward in the facing direction
	var direction = -transform.basis.z  # Forward vector
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()





func _on_enemy_body_entered(body):
	if body is PBullet and imunity == false:
		timer.start()
		health -= 3


func _on_timer_timeout():
	imunity = false


func _on_shot_area_body_entered(body: Node3D) -> void:
	if body is player and shoot_avalible == true:
		shoot_avalible = false
		delay_timer.start()
		var instance = bullet_scene.instantiate()
		instance.global_transform = spawn_pos.global_transform
		get_parent().add_child(instance)


func _on_shoot_delay_timeout() -> void:
	shoot_avalible = true
