extends CharacterBody2D

var moving_left = true
var movment_speed = 100
var jump_velocity = 0
var wind_speed = 0
const Gravity = 10

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
		if collision:
			var normal = collision.get_normal()
			if normal.x < 0:
				moving_left = true
			elif normal.x > 0:
				moving_left = false
			print(normal)


@warning_ignore("unused_parameter")
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print("enemy triggered by:", body)
	if body.has_method("respawn"):
		print("Calling respawn() on:", body.name)
		body.respawn()
	else: 
		pass
