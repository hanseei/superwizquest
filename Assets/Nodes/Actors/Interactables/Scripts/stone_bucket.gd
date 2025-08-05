extends Interactable

func _ready():
	activateGroups = ["stones"]
	

func body_entered(body: Node):
	for group in activateGroups:
		if (body.is_in_group(group)):
			activateTrigger()
			return

func Stone_inside():
	print("stone in box")
	
