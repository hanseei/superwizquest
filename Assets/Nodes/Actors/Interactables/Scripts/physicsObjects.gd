extends RigidBody2D

class_name physicsObjects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var wind = get_node("../Player/Wind")
#	wind.connect("wind_updated", Callable(self, "_on_wind_updated"))
	
	print(wind)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_wind_wind_updated(x_speed: Variant, z_speed: Variant) -> void:
	print( "wind on stone")
	if x_speed != 0:
		constant_force = Vector2(0, 1) * x_speed
	if z_speed !=0:
		print(z_speed+"z speed")
