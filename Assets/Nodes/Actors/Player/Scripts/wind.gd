extends Node

signal wind_updated(speed)

var wind_speed := 0.0
var active := false

func activate_wind():
	print("wind active")
	active = true
	wind_speed = 200.0
	emit_signal("wind_updated", wind_speed)
	await get_tree().create_timer(5.0).timeout
	deactivate_wind()

func deactivate_wind():
	active = false
	wind_speed = 0.0
	emit_signal("wind_updated", wind_speed)
