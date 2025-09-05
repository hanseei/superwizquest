extends Area2D

@export var speed := 500

var velocity := Vector2.ZERO

func _ready():
	$VisibleOnScreenEnabler2D.screen_exited.connect(_on_VisibilityNotifier2D_screen_exited)
	if (velocity.x <= 0):
		$AnimatedSprite2D.flip_h = true
	$Waterplop.pitch_scale = 1.15 - (randf()/2)

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

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer || !body.is_in_group("mob"):
		queue_free()
	else:
		if body.has_method("wet"):
			body.wet()
		else:
			print(body, " doesn't have wet function")
