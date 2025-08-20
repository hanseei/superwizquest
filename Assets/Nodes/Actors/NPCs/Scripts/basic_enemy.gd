extends CharacterBody2D

const Gravity = 10

@onready var spawn_point = get_node("/root/TestStage/SpawnPointFrog")

var movment_speed = 100
var jump_velocity = 0
var wind_speed = 0
var direction = -1
var soaking  = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	velocity.x = direction * movment_speed + Gamecontroller.global_x_speed
	
	if !is_on_floor():
		
		velocity.y = 1600 * Gravity * delta
		$AnimatedSprite2D.frame = 7
	
	if Gamecontroller.global_z_speed != 0:
		velocity.y = Gamecontroller.global_z_speed* 4 * delta
		$AnimatedSprite2D.frame = 5
	
	move_and_slide()
	
	if is_on_wall():
		var collision = get_slide_collision(0)
		var collider = collision.get_collider()
		if collider.has_method("respawn"):
			print("Calling respawn() on:", collider.name)
			collider.respawn()
			
		if collision:
			var normal = collision.get_normal()
			if normal.x < 0:
				direction = -1
				$AnimatedSprite2D.flip_h = false
			elif normal.x > 0:
				direction = 1
				$AnimatedSprite2D.flip_h = true
			print(normal)

func respawn():
	print("Respawning enemy...")
	global_position = spawn_point.global_position
	velocity = Vector2.ZERO
	
func wet():
	if soaking == false:
		print("wet frog")
		soaking = true
		var base_speed = movment_speed
		print(movment_speed)
		movment_speed = base_speed/2
		$AnimatedSprite2D.speed_scale = 0.5
		await get_tree().create_timer(5.0).timeout
		movment_speed = base_speed
		$AnimatedSprite2D.speed_scale = 1
		print(movment_speed)
		soaking = false
	else:
		pass
