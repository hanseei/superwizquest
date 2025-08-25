extends Interactable

var lift: bool = false
@export var platformSpeed: float = 1

func _ready():
	activateGroups = ["waters"]
	deactivateGroups = ["fires"]
	activated.connect(procLift.bind(true))
	deactivated.connect(procLift.bind(false))
	super._ready()

func _process(delta):
	if (lift && $Path2D/PathFollow2D.progress_ratio < 1):
		$Path2D/PathFollow2D.progress_ratio += delta * platformSpeed
	elif (!lift && $Path2D/PathFollow2D.progress_ratio > 0):
		$Path2D/PathFollow2D.progress_ratio -= delta * platformSpeed
		
func procLift(active:bool):
	lift = active
