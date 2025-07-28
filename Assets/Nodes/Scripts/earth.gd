extends StaticBody2D

@export var rise_height := 70
@export var rise_speed := 200

var start_position := Vector2.ZERO
var target_position := Vector2.ZERO

func _ready():
	start_position = position
	target_position = position - Vector2(0, rise_height)
	set_process(true)

func _process(delta):
	if position.y > target_position.y:
		position.y -= rise_speed * delta
	else:
		position.y = target_position.y
		set_process(false)
