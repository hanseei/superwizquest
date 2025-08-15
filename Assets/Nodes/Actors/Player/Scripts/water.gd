extends Area2D

@export var speed := 500

var velocity := Vector2.ZERO

func _ready():
	$VisibleOnScreenEnabler2D.screen_exited.connect(_on_VisibilityNotifier2D_screen_exited)
	if (velocity.x <= 0):
		$AnimatedSprite2D.flip_h = true

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	if (velocity.y > 5):
		$AnimatedSprite2D.frame = 3
	elif (velocity.y < 5 && velocity.y > -5):
		$AnimatedSprite2D.frame = 2
	elif(velocity.y < -5):
		$AnimatedSprite2D.frame = 1


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

@warning_ignore("unused_parameter")
func _on_Area2D_body_entered(body):
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
	else:
		print("water triggered by:", body)
		if body.has_meta("wet"):
			body.wet
		else:
			print(body, " doesn't have wet function")
