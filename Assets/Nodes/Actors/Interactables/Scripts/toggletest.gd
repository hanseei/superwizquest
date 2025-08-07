extends ObjectTrigger

func _ready():
	super._ready()
	triggered.connect(_lightSprite.bind(true))
	detriggered.connect(_lightSprite.bind(false))
	

func _lightSprite(lightUp: bool):
	if lightUp:
		$AnimatedSprite2D.animation = "activated"
	else:
		$AnimatedSprite2D.animation = "default"
