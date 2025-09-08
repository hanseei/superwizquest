extends Physicsable

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$StoneAnim.global_rotation = 0
	var stoneRot = global_rotation - int(global_rotation)
	if global_rotation < 0.25: $StoneAnim.frame = 0
	elif global_rotation >= 0.25 && global_rotation < 0.5: $StoneAnim.frame = 1
	elif global_rotation >= 0.5 && global_rotation < 0.75: $StoneAnim.frame = 2
	elif global_rotation >= 0.75 && global_rotation < 1: $StoneAnim.frame = 3
