extends ObjectTrigger

@export var targetPos: Vector2 = Vector2(0,-64)
var open: bool = false


func _ready():
	super._ready()
	$Path2D.get_curve().set_point_position(1,targetPos)
	triggered.connect(_opens)
	detriggered.connect(_closes)
	
func _process(delta):
	if (open && $Path2D/PathFollow2D.progress_ratio < 1):
		$Path2D/PathFollow2D.progress_ratio += delta
	elif (!open && $Path2D/PathFollow2D.progress_ratio > 0):
		$Path2D/PathFollow2D.progress_ratio -= delta
	
func _opens():
	open = true

func _closes():
	open = false
