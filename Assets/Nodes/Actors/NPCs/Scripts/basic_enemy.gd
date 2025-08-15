extends CharacterBody2D

const Gravity = 10

@onready var spawn_point = get_node("/root/TestStage/SpawnPointFrog")

var moving_left = true
var movment_speed = 100
var jump_velocity = 0
var wind_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var direction = -1
	if moving_left == true:
		direction = -1
	elif moving_left == false:
		direction = 1
		
	velocity.x = direction * movment_speed + Gamecontroller.global_x_speed
	
	if !is_on_floor():
		
		velocity.y = 800* Gravity * delta
	
	if jump_velocity != 0:
		velocity.y = jump_velocity * delta
	
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
				moving_left = true
			elif normal.x > 0:
				moving_left = false
			print(normal)

func respawn():
	print("Respawning enemy...")
	global_position = spawn_point  # or wherever you want to reset
	velocity = Vector2.ZERO
