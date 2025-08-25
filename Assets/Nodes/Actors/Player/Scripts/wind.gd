extends Node

signal wind_updated()

var active := false

func activate_wind():
	
	if active == false:
		
		active = true
		
		if Gamecontroller.global_direction.normalized() == Vector2.RIGHT:
			
			Gamecontroller.global_x_speed = 200.0
			Gamecontroller.global_z_speed = 0
			
		if Gamecontroller.global_direction.normalized() ==  Vector2.LEFT:
			
			Gamecontroller.global_x_speed = -200.0
			Gamecontroller.global_z_speed = 0

			
		if Gamecontroller.global_direction.normalized() ==  Vector2.DOWN:
			
			Gamecontroller.global_x_speed = 0
			Gamecontroller.global_z_speed = 16000
		
			
		if Gamecontroller.global_direction.normalized() ==  Vector2.UP:
			
			Gamecontroller.global_x_speed = 0
			Gamecontroller.global_z_speed = -2000
			
		
		emit_signal("wind_updated")
		get_tree().call_group("moveable","_on_wind_updated")
		#print("wind on")

func deactivate_wind():
	active = false
	Gamecontroller.global_x_speed = 0.0
	Gamecontroller.global_z_speed = 0.0
	emit_signal("wind_updated")
	get_parent().call("_on_wind_updated")
	#print("wind off")
