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

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
	else:
		if body.has_method("wet"):
			body.wet()
		else:
			print(body, " doesn't have wet function")
