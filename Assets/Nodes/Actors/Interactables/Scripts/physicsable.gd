extends RigidBody2D

class_name Physicsable

var wind_speed = 0
var jump_velocity = 0

var moving = false


func _on_wind_updated(x_speed: Variant, z_speed: Variant):
		
	if Gamecontroller.global_direction.normalized() == Vector2.RIGHT:
		
		wind_speed = 200.0
		jump_velocity = 0
		
	if Gamecontroller.global_direction.normalized() ==  Vector2.LEFT:
		
		wind_speed = -200.0
		jump_velocity = 0
		
	if Gamecontroller.global_direction ==  Vector2.DOWN:
		
		wind_speed = 0
		jump_velocity = 1600
		
	if Gamecontroller.global_direction ==  Vector2.UP:
		
		wind_speed = 0
		jump_velocity = -1000
	
	if Gamecontroller.global_direction == Vector2.ZERO:
		wind_speed = 0
		jump_velocity = 0
		print("no direction")
	
	
	if x_speed or z_speed != 0:
		moving = true
		await get_tree().create_timer(5.0).timeout
		moving = false
		


func _physics_process(delta: float) -> void:
	if moving:
		apply_central_force(Vector2(wind_speed, jump_velocity))
