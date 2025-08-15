extends Area2D

var speed = 750
var velocity = Vector2.ZERO

func _ready():
	$VisibleOnScreenEnabler2D.screen_exited.connect(_on_VisibilityNotifier2D_screen_exited)

func _physics_process(delta: float):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

@warning_ignore("unused_parameter")
func _on_Area2D_body_entered(body):
	queue_free()
	
#	A function called from player to determine which way the fireball sprite should face
func setAnimDirection(facing_left: bool):
	match facing_left:
		false: $AnimatedSprite2D.flip_h = true


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
	else:
		print("fireball triggered by:", body)
		if body.has_method("respawn"):
			print("Calling respawn() on:", body.name)
			body.respawn()
		else:
			print(body.name, "has no respawn() method")
