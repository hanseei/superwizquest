extends RigidBody2D

class_name Physicsable

var moving = false


func _on_wind_updated():
		
	if Gamecontroller.global_direction.normalized() == Vector2.RIGHT:
		
		Gamecontroller.global_x_speed = 200.0
		Gamecontroller.global_z_speed = 0
		
	if Gamecontroller.global_direction.normalized() ==  Vector2.LEFT:
		
		Gamecontroller.global_x_speed = -200.0
		Gamecontroller.global_z_speed = 0
		
	if Gamecontroller.global_direction ==  Vector2.DOWN:
		
		Gamecontroller.global_x_speed = 0
		Gamecontroller.global_z_speed = 1600
		
	if Gamecontroller.global_direction ==  Vector2.UP:
		
		Gamecontroller.global_x_speed = 0
		Gamecontroller.global_z_speed = -1000
	
	if Gamecontroller.global_direction == Vector2.ZERO:
		Gamecontroller.global_x_speed = 0
		Gamecontroller.global_z_speed = 0
		print("no direction")
	
	
	if Gamecontroller.global_x_speed or Gamecontroller.global_z_speed != 0:
		moving = true
		print("moving")
		await get_tree().create_timer(Gamecontroller.wind_timer).timeout
		moving = false
		

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if moving:
		apply_central_force(Vector2(Gamecontroller.global_x_speed, Gamecontroller.global_z_speed))
