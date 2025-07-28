extends Area2D

@export var speed := 800
var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	queue_free()
