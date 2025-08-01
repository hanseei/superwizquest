extends Node

signal wind_updated(speed)

var wind_speed := 0.0
var active := false

func activate_wind(direction):
	
	
	if active == false:
		
		print("wind active")
		
		if direction.normalized() == Vector2.RIGHT:
			
			wind_speed = 200.0
			emit_signal("wind_updated", wind_speed)
			await get_tree().create_timer(5.0).timeout
			deactivate_wind()
			
		if direction.normalized() ==  Vector2.LEFT:
			
			wind_speed = -200.0
			emit_signal("wind_updated", wind_speed)
			await get_tree().create_timer(5.0).timeout
			deactivate_wind()
			
		if direction.normalized() ==  Vector2.DOWN:
			
			wind_speed = 0
			emit_signal("wind_updated", wind_speed)
			await get_tree().create_timer(5.0).timeout
			deactivate_wind()
			
		if direction.normalized() ==  Vector2.UP:
			
			wind_speed = 0
			emit_signal("wind_updated", wind_speed)
			await get_tree().create_timer(5.0).timeout
			deactivate_wind()
			
		
		active = true

func deactivate_wind():
	active = false
	wind_speed = 0.0
	emit_signal("wind_updated", wind_speed)
