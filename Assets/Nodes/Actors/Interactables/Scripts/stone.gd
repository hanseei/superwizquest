extends Physicsable

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$StoneAnim.global_rotation = 0
	var stoneRot = global_rotation - int(global_rotation)
	if stoneRot < 0: stoneRot +=1
	if stoneRot >= 0 && stoneRot < 0.25: $StoneAnim.frame = 0
	elif stoneRot >= 0.25 && stoneRot < 0.5: $StoneAnim.frame = 1
	elif stoneRot >= 0.5 && stoneRot < 0.75: $StoneAnim.frame = 2
	elif stoneRot >= 0.75 && stoneRot < 1: $StoneAnim.frame = 3
