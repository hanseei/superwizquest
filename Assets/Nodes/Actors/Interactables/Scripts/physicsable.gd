extends RigidBody2D

class_name Physicsable

var wind_speed = 0
var jump_velocity = 0

func _on_wind_updated(x_speed: Variant, z_speed: Variant):
		
	if Gamecontroller.global_direction.normalized() == Vector2.RIGHT:
		
		wind_speed = 2000.0
		jump_velocity = 0
		print("right")
		
	if Gamecontroller.global_direction.normalized() ==  Vector2.LEFT:
		
		wind_speed = -2000.0
		jump_velocity = 0
		print("left")
		
	if Gamecontroller.global_direction ==  Vector2.DOWN:
		
		wind_speed = 0
		jump_velocity = 16000
		print("down")
		
	if Gamecontroller.global_direction ==  Vector2.UP:
		
		wind_speed = 0
		jump_velocity = -2000
		print("up")
	
	if Gamecontroller.global_direction == Vector2.ZERO:
		wind_speed = 0
		jump_velocity = 0
		print("no direction")
	
	
	if x_speed != 0:
		print("x speed")
		apply_central_force(Vector2(wind_speed, 0))
		await get_tree().create_timer(5.0).timeout
		constant_force = Vector2(0, 0)
			
	if z_speed !=0:
		apply_central_force(Vector2(0, jump_velocity))
		print("z speed")
		await get_tree().create_timer(5.0).timeout
		constant_force = Vector2(0, 0)
