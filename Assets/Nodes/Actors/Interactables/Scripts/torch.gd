extends Area2D

@export var state = false

signal doused
signal lit

#	If hit with a firebolt, check if already lit, if not, light and emit 'lit' signal.
func lightTorch():
	if (!state):
		state = true
		$AnimatedSprite2D.animation = "burning"
		lit.emit()
		
#	If hit with water, check if already doused, if not, douse and emit 'doused' signal.
func douseTorch():
	if (state):
		state = false
		$AnimatedSprite2D.animation = "default"
		doused.emit()

#	On collision (layer 4), check if object is in group 'fires' or 'waters', and call the related function.
func area_entered(area: Area2D):
	if (area.is_in_group("fires")):
		lightTorch()
	elif (area.is_in_group("waters")):
		douseTorch()
