extends Interactable

func _ready():
	activateGroups = ["stones"]
	activated.connect(Stone_inside)
	super._ready()
	

func Stone_inside():
	print("stone in box")
	
