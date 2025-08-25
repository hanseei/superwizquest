extends Area2D

@export var platformSpeed: int = 16

@export var pathNodes: Array[Vector2]

func _ready():
	for node in pathNodes:
		$Path2D.get_curve().add_point(node)
	#print($Path2D.get_curve().point_count)

func _process(delta):
	$Path2D/PathFollow2D.progress_ratio += delta * platformSpeed * 0.01
	if ($Path2D/PathFollow2D.progress_ratio >= 1):
		$Path2D/PathFollow2D.progress_ratio -= 1
		
	
