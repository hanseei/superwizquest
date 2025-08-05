extends RigidBody2D

class_name physicsObjects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var wind = get_node("../Player/Wind")
	if (wind):
		wind.connect("wind_updated", Callable(self, "_on_wind_wind_updated"))
		print(wind)
		_on_wind_wind_updated(1000,0)
	else:
		push_warning("!!No player with a wind-object detected!!")
	

func _on_wind_wind_updated(x_speed: Variant, z_speed: Variant) -> void:
	print( "wind on stone")
	if x_speed != 0:
		constant_force = Vector2(0, 1) * x_speed
	if z_speed !=0:
		print(z_speed+"z speed")
