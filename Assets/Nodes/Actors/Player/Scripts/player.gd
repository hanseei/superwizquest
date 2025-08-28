extends CharacterBody2D

const Gravity = 10

@export var speed = 400 # How fast the player will move (pixels/sec).

@export var worldTileOffset = 0

var jump_velocity = 0
var wind_speed = 0
var wind_active = false

@onready var orb = get_node("Orb")

const fire = preload("res://Assets/Nodes/Actors/Player/fire.tscn")
const water = preload("res://Assets/Nodes/Actors/Player/water.tscn")
const earth = preload("res://Assets/Nodes/Actors/Player/earth.tscn")
const wind = preload("res://Assets/Nodes/Actors/Player/wind.tscn")

var elements = ["fire", "water", "earth", "wind"]
var current_element_index = 0
var current_element = "fire"

var active_earth: Node = null
var facing_left = false
var up_key = false
var down_key = false

func _ready():
	
	$"Ui-canvas/Ui-icon/AnimatedSprite2D".animation = current_element
	$AnimatedSprite2D.animation = current_element + "_walk"
	


func _physics_process(delta: float):
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed + wind_speed
	
	if !is_on_floor():
		
		velocity.y = 1200 * Gravity * delta

	
	if jump_velocity != 0:
		velocity.y = jump_velocity * delta
	
	if direction != 0:
		facing_left = direction < 0
		
	if facing_left:
		$AnimatedSprite2D.flip_h = false
		$Orb.position.x = -15
	else:
		$AnimatedSprite2D.flip_h = true
		$Orb.position.x = 15
	
	move_and_slide()
	

func _input(event):
	
	if event.is_action_pressed("space"):
		shoot_element()
		
	if event.is_action_pressed("move_up"):
		up_key = true
		#print("up pressed")
	if event.is_action_released("move_up"):
		up_key = false
		#print("up released")
		
	if event.is_action_pressed("move_down"):
		down_key = true
		#print("down pressed")
	if event.is_action_released("move_down"):
		down_key = false
		#print("down released")
		print(Gamecontroller.wind_timer)
		
	if event.is_action_pressed("R"):
		#print("R")
		respawn()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("E"):
		current_element_index = (current_element_index + 1) % elements.size()
		current_element = elements[current_element_index]
		$"Ui-canvas/Ui-icon/AnimatedSprite2D".animation = current_element
		#print("Switched to:", current_element)
	if event.is_action_pressed("Q"):
		current_element_index = (current_element_index - 1) % elements.size()
		current_element = elements[current_element_index]
		$"Ui-canvas/Ui-icon/AnimatedSprite2D".animation = current_element
		#print("Switched to:", current_element)
	$AnimatedSprite2D.animation = current_element + "_walk"


func shoot_single(scene: PackedScene):
	var shot = scene.instantiate()
	shot.global_position = $Orb.global_position
	shot.velocity = Vector2.LEFT * shot.speed if facing_left else Vector2.RIGHT * shot.speed
	shot.setAnimDirection(facing_left)
	get_tree().current_scene.add_child(shot)

func shoot_water_burst(scene: PackedScene):
	var launch_angle = deg_to_rad(25)       
	var direction = Vector2(cos(launch_angle), -sin(launch_angle))

	# Flip direction if facing left
	if facing_left:
		direction.x *= -1

	for i in 10:
		await get_tree().create_timer(0.05).timeout

		var shot = scene.instantiate()
		shot.global_position = $Orb.global_position
		shot.velocity = direction.normalized() * shot.speed
		get_tree().current_scene.add_child(shot)

func summon_earth_block():
	if earth:
		
		if active_earth and is_instance_valid(active_earth):
			active_earth.queue_free()

		# Start from the Orb position
		var spawn_pos = $Orb.global_position

		# Offset forward based on facing direction
		var offset := Vector2(128, -32)  # Adjust distance as needed
		if down_key == true || up_key == true:
			offset.x = 0
		if facing_left:
			offset.x *= -1
			
		spawn_pos += offset

		
		var ray_goal = spawn_pos + Vector2(0,128)
		var space_state = get_world_2d().direct_space_state

		var query = PhysicsRayQueryParameters2D.create(spawn_pos, ray_goal, 1)

		var result = space_state.intersect_ray(query)
		
		if (!result.is_empty()):
			spawn_pos = result.get("position")
			var modifier: int = int(spawn_pos.x) % 32
			if (modifier >= 16):
				modifier -= 32
			spawn_pos.x = spawn_pos.x - modifier - worldTileOffset
			ray_goal = spawn_pos - Vector2(0,64)
			if (offset.x == 0):
				var spaceQuery = PhysicsRayQueryParameters2D.create(spawn_pos, ray_goal, 1)
				var spaceResult = space_state.intersect_ray(spaceQuery)
				if(spaceResult.is_empty()):
					var block = earth.instantiate()
					block.position = spawn_pos
					get_tree().current_scene.add_child(block)
					active_earth = block
			else:
				var block = earth.instantiate()
				block.position = spawn_pos
				get_tree().current_scene.add_child(block)
				active_earth = block
			


		

func cast_wind():
	
	var direction := Vector2.LEFT if facing_left else Vector2.RIGHT
		
	if up_key:
		direction = Vector2.UP
	if down_key:
		direction = Vector2.DOWN
	
	Gamecontroller.global_direction = direction
	if is_on_floor(): 
		if wind_active == false:
			
			wind_active = true
			
			$Wind.activate_wind()
			
			await get_tree().create_timer(Gamecontroller.wind_timer).timeout
			
			$Wind.deactivate_wind()
			
			wind_active = false
	else:
		pass
	
func _on_wind_updated():
	wind_speed = Gamecontroller.global_x_speed
	jump_velocity = Gamecontroller.global_z_speed
	

func shoot_element():
	match current_element:
		"fire": shoot_single(fire)
		"water": shoot_water_burst(water)
		"earth": summon_earth_block()
		"wind": cast_wind()

func respawn():
	Gamecontroller.update_spawn()
	print("Respawning player...")
	global_position = Gamecontroller.spawn_point.global_position
	velocity = Vector2.ZERO
