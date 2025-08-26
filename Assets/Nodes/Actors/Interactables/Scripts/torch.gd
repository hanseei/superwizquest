extends Interactable

var respawn_used = false

func _ready():
	activateGroups = ["fires"]
	deactivateGroups = ["waters"]
	activated.connect(lightTorch)
	deactivated.connect(douseTorch)
	super._ready()

#	If hit with a firebolt, check if already lit, if not, light and emit 'lit' signal.
func lightTorch():
		$AnimatedSprite2D.animation = "burning"
		if is_in_group("respawn"):
			if respawn_used == false:
				Gamecontroller.respawn_counter += 1
				respawn_used = true
			else:
				pass
		
#	If hit with water, check if already doused, if not, douse and emit 'doused' signal.
func douseTorch():
		$AnimatedSprite2D.animation = "default"
