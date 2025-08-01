extends Interactable

func _ready():
	activateGroups = ["fires"]
	deactivateGroups = ["waters"]

#	If hit with a firebolt, check if already lit, if not, light and emit 'lit' signal.
func lightTorch():
		$AnimatedSprite2D.animation = "burning"
		
#	If hit with water, check if already doused, if not, douse and emit 'doused' signal.
func douseTorch():
		$AnimatedSprite2D.animation = "default"
