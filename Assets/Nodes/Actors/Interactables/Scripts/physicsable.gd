extends RigidBody2D

class_name Physicsable

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	apply_central_force(Vector2(Gamecontroller.global_x_speed, Gamecontroller.global_z_speed))
