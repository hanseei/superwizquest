extends Area2D

var moveRight: bool = true
var moving: bool = false

@export var platformSpeed: int = 32

@export var pathNodes: Array[Vector2]

func _ready():
	for node in pathNodes:
		$Path2D.get_curve().add_point(node)

func _process(delta):
	if (moving):
		if (moveRight && $Path2D/PathFollow2D.progress_ratio < 1):
			$Path2D/PathFollow2D.progress_ratio += delta * platformSpeed * 0.01
			if ($Path2D/PathFollow2D.progress_ratio >= 1):
				$Path2D/PathFollow2D.progress_ratio = 1
				$Path2D/PathFollow2D/AnimatedSprite2D.animation = "default"
				moving = false
		elif (!moveRight && $Path2D/PathFollow2D.progress_ratio > 0):
			$Path2D/PathFollow2D.progress_ratio -= delta * platformSpeed * 0.01
			if ($Path2D/PathFollow2D.progress_ratio <= 0):
				$Path2D/PathFollow2D.progress_ratio = 0
				$Path2D/PathFollow2D/AnimatedSprite2D.animation = "default"
				moving = false

@warning_ignore("unused_parameter")
func _on_wind_updated(x_speed: Variant, z_speed: Variant):
	moveRight = !moveRight
	moving = true
	$Path2D/PathFollow2D/AnimatedSprite2D.animation = "moving"
	$Path2D/PathFollow2D/AnimatedSprite2D.play()
	
