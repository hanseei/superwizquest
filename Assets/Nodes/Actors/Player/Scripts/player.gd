extends CharacterBody2D

const Gravity = 2000

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var jump_velocity = -400
@export var spawn_point_node: NodePath

var wind_speed = 0

var spawn_point := Vector2.ZERO

const fire = preload("res://Assets/Nodes/Actors/Player/fire.tscn")
const water = preload("res://Assets/Nodes/Actors/Player/water.tscn")
const earth = preload("res://Assets/Nodes/Actors/Player/earth.tscn")
const wind = preload("res://Assets/Nodes/Actors/Player/wind.tscn")

var elements = ["fire", "water", "earth", "wind"]
var current_element_index = 0
var current_element = "fire"

var active_earth: Node = null
var facing_left = false

func _ready():
	if has_node(spawn_point_node):
		spawn_point = get_node(spawn_point_node).global_position
		

func _physics_process(delta: float):
	
	if not is_on_floor():
		velocity.y += Gravity * delta
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed + wind_speed
	
	if direction != 0:
		facing_left = direction < 0
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_velocity
	
	move_and_slide()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		current_element_index = (current_element_index + 1) % elements.size()
		current_element = elements[current_element_index]
		print("Switched to:", current_element)

func shoot_single(scene: PackedScene):
	var shot = scene.instantiate()
	shot.global_position = $Orb.global_position
	shot.velocity = Vector2.LEFT * shot.speed if facing_left else Vector2.RIGHT * shot.speed
	shot.setAnimDirection(facing_left)
	get_tree().current_scene.add_child(shot)

func shoot_water_burst(scene: PackedScene):
	var launch_angle = deg_to_rad(50)       
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
			
		var block = earth.instantiate()

		# Start from the Orb position
		var spawn_pos = $Orb.global_position

		# Offset forward based on facing direction
		var offset := Vector2(100, 50)  # Adjust distance as needed
		if facing_left:
			offset.x *= -1

		spawn_pos += offset
		block.position = spawn_pos

		get_tree().current_scene.add_child(block)
		
		active_earth = block

func cast_wind():
	
	var direction := Vector2.LEFT if facing_left else Vector2.RIGHT
	
	var wind_instance = wind.instantiate()
	get_tree().current_scene.add_child(wind_instance)
	
	wind_instance.connect("wind_updated", self._on_wind_updated)
	
	wind_instance.activate_wind()

	print(speed)

func _on_wind_updated(speed):
	wind_speed = speed
	
	if speed == 0:
		# Assume wind has finished — remove it
		var wind_instance = get_node("WindController")
		if wind_instance:
			wind_instance.queue_free()


func shoot_element():
	match current_element:
		"fire": shoot_single(fire)
		"water": shoot_water_burst(water)
		"earth": summon_earth_block()
		"wind": cast_wind()



func _input(event):
	
	if event.is_action_pressed("space"):
		shoot_element()


func respawn():
	print("Respawning player...")
	global_position = spawn_point  # or wherever you want to reset
	velocity = Vector2.ZERO
