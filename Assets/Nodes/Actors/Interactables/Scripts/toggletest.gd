extends Node2D
#	Will be used to connect the 'light' on this sprite to the signal of a given torch.
@export var triggerObjectName = "Torch"
var triggerObject


#func _ready():
#	if(get_node(triggerObjectName)):
#		SceneTree
#			triggerObject = get_node(triggerObjectName) 
#			triggerObject.lit.connect("lightUp")
	

func lightUp():
	$AnimatedSprite2D.animation = "activated"
