extends RigidBody2D

class_name Physicsable

func _on_wind_updated(x_speed: Variant, z_speed: Variant):
	print("wind on stone")
	if x_speed != 0:
		constant_force = Vector2(0, 1) * x_speed
	if z_speed !=0:
		print(z_speed," z speed")
