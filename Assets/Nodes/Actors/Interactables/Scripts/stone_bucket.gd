extends Interactable

func _ready():
	activateGroups = ["stones"]
	activated.connect(setSprite.bind(true))
	deactivated.connect(setSprite.bind(false))
	super._ready()
	
func setSprite(pressed:bool):
	if pressed:
		$AnimatedSprite2D.animation = "active"
	else:
		$AnimatedSprite2D.animation = "default"
