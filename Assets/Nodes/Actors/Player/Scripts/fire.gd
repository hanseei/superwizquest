extends Area2D

var speed = 750
var velocity = Vector2.ZERO

func _physics_process(delta: float):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	queue_free()
	
#	A function called from player to determine which way the fireball sprite should face
func setAnimDirection(facing_left: bool):
	match facing_left:
		false: $AnimatedSprite2D.flip_h = true
