extends Node2D
#	Will be used to connect the 'light' on this sprite to the signal of a given torch.

@export var triggerObject: Area2D
var lit: bool = false


func _ready():
	triggerObject.lit.connect(_lightUp)
	triggerObject.doused.connect(_lightDown)
	

func _lightUp():
	$AnimatedSprite2D.animation = "activated"

func _lightDown():
	$AnimatedSprite2D.animation = "default"
