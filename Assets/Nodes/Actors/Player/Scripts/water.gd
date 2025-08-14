extends Area2D

@export var speed := 500

var velocity := Vector2.ZERO

func _ready():
	$VisibleOnScreenEnabler2D.screen_exited.connect(_on_VisibilityNotifier2D_screen_exited)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

@warning_ignore("unused_parameter")
func _on_Area2D_body_entered(body):
	queue_free()
