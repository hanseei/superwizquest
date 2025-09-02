extends RigidBody2D

class_name Physicsable

var is_visible_on_screen := false

@onready var screen_notifier = $VisibleOnScreenNotifier2D

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if is_visible_on_screen == true:
		apply_central_force(Vector2(Gamecontroller.global_x_speed, Gamecontroller.global_z_speed))

func _screen_exited() -> void:
	is_visible_on_screen = false

func _screen_entered() -> void:
	is_visible_on_screen = true
