extends Interactable

var lift: bool = false
var plantSpeed: float = 1.6

func _ready():
	activateGroups = ["waters"]
	deactivateGroups = ["fires"]
	activated.connect(procLift.bind(true))
	deactivated.connect(procLift.bind(false))
	super._ready()

func _process(delta):
	if (lift && $Path2D/PathFollow2D.progress_ratio < 1):
		$Path2D/PathFollow2D.progress_ratio += delta * plantSpeed
	elif (!lift && $Path2D/PathFollow2D.progress_ratio > 0):
		$Path2D/PathFollow2D.progress_ratio -= delta * plantSpeed
		
func procLift(active:bool):
	lift = active
