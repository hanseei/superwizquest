extends ObjectTrigger

@export var wantedPos: Vector2
var targetPos: Vector2

var open: bool = false


func _ready():
	super._ready()
	targetPos = Vector2(0,96)
	if (wantedPos): 
		$Path2D.get_curve().set_point_position(1,wantedPos)
	else:
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
