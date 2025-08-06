extends Node

signal wind_updated(x_speed, z_speed)

var wind_speed := 0.0
var jump_velocity := 0.0
var active := false


func activate_wind(direction):
	
	if active == false:
		
		active = true
		
		if direction.normalized() == Vector2.RIGHT:
			
			wind_speed = 200.0
			jump_velocity = 0
			
		if direction.normalized() ==  Vector2.LEFT:
			
			wind_speed = -200.0
			jump_velocity = 0

			
		if direction.normalized() ==  Vector2.DOWN:
			
			wind_speed = 0
			jump_velocity = 16000
		
			
		if direction.normalized() ==  Vector2.UP:
			
			wind_speed = 0
			jump_velocity = -2000
			
		
		emit_signal("wind_updated", wind_speed, jump_velocity)
		get_tree().call_group("moveable","_on_wind_updated",wind_speed,jump_velocity)
		await get_tree().create_timer(5.0).timeout
		deactivate_wind()

func deactivate_wind():
	active = false
	wind_speed = 0.0
	jump_velocity = 0.0
	emit_signal("wind_updated", wind_speed, jump_velocity)
	
