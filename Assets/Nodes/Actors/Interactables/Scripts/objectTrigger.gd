extends Node2D

class_name ObjectTrigger

enum LOGIC {AND, OR, NAND, NOR}

@export var logic: LOGIC = LOGIC.AND
@export var triggerObjectArray: Array[Area2D]

var counter: int = 0 # Current number of lit torches
var maxAmnt: int = 0 # Amount of torches checked
var lit: bool = false # Checks whether signal is good or bad

signal triggered
signal detriggered

# TODO: Potential for refactor with changing the order of match and for loop, or having one bound function that does the match instead
func _ready():
	maxAmnt = triggerObjectArray.size()
	if (triggerObjectArray.size() > 0):
		match logic:
			LOGIC.AND:
				for triggerObject in triggerObjectArray:
					triggerObject.activated.connect(_andFunc.bind(true))
					triggerObject.deactivated.connect(_andFunc.bind(false))
			LOGIC.OR:
				for triggerObject in triggerObjectArray:
					triggerObject.activated.connect(_orFunc.bind(true))
					triggerObject.deactivated.connect(_orFunc.bind(false))
			LOGIC.NAND:
				for triggerObject in triggerObjectArray:
					triggerObject.activated.connect(_nandFunc.bind(true))
					triggerObject.deactivated.connect(_nandFunc.bind(false))
				lit = true
				_light()
			LOGIC.NOR:
				for triggerObject in triggerObjectArray:
					triggerObject.activated.connect(_norFunc.bind(true))
					triggerObject.deactivated.connect(_norFunc.bind(false))
				lit = true
				_light()

# Ups and downs the counter, toggles lit if all torches are lit
func _andFunc(activated: bool):
	if (activated):
		counter += 1
	else:
		counter -= 1
		
	if (counter >= maxAmnt):
		lit = true
	else:
		lit = false
	_light()

# Ups and downs the counter, toggles lit if at least one torch is lit
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
	
# Ups and downs the counter, toggles lit if not all torches are lit
func _nandFunc(activated: bool):
	if (activated):
		counter += 1
	else:
		counter -= 1
	if (counter < maxAmnt):
		lit = true
	else:
		lit = false
	_light()
	
# Ups and downs the counter, toggles lit if no torches are lit
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
		triggered.emit()
	else:
		detriggered.emit()
