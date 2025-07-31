extends Node2D
#	Will be used to connect the 'light' on this sprite to the signal of a given torch.

enum LOGIC {AND, OR, NAND, NOR}


@export var logic: LOGIC = 0
@export var triggerObjectArray: Array[Area2D]
var counter: int = 0
var max: int = 0
var lit: bool = false

func _ready():
	max = triggerObjectArray.size()
	if (triggerObjectArray.size() > 0):
		match logic:
			LOGIC.AND:
				for triggerObject in triggerObjectArray:
					triggerObject.lit.connect(_andFunc.bind(true))
					triggerObject.doused.connect(_andFunc.bind(false))
			LOGIC.OR:
				for triggerObject in triggerObjectArray:
					triggerObject.lit.connect(_orFunc.bind(true))
					triggerObject.doused.connect(_orFunc.bind(false))
			LOGIC.NAND:
				for triggerObject in triggerObjectArray:
					triggerObject.lit.connect(_nandFunc.bind(true))
					triggerObject.doused.connect(_nandFunc.bind(false))
			LOGIC.NOR:
				for triggerObject in triggerObjectArray:
					triggerObject.lit.connect(_norFunc.bind(true))
					triggerObject.doused.connect(_norFunc.bind(false))

# Simply ups the counter when a torch is lit, downs it when unlit, and toggles when counter is equal to max
func _andFunc(activated: bool):
	if (activated):
		counter += 1
	else:
		counter -= 1
		
	if (counter >= max):
		lit = true
	else:
		lit = false
	_light()

	
func _orFunc(activated: bool):
	if (activated):
		counter += 1
	else:
		counter -= 1
	if (counter >= 1):
		lit = true
	else:
		lit = false
	_light()
	
func _nandFunc(activated: bool):
	if (activated):
		counter += 1
	else:
		counter -= 1
	if (counter < max):
		lit = true
	else:
		lit = false
	_light()	
	
func _norFunc(activated: bool):
	if (activated):
		counter += 1
	else:
		counter -= 1
	if (counter == 0):
		lit = true
	else:
		lit = false
	_light()	
	
	

func _light():
	if (lit):
		$AnimatedSprite2D.animation = "activated"
	else:
		$AnimatedSprite2D.animation = "default"
