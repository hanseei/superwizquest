extends Area2D

class_name Interactable

@export var state: bool
var activateGroups: Array[String]
var deactivateGroups: Array[String]

signal deactivated
signal activated

func _ready():
	area_entered.connect(_on_area_entered)
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if (state): 
		state = false
		activateTrigger()
	

#	If hit with a firebolt, check if already lit, if not, light and emit 'lit' signal.
func activateTrigger():
	if (!state):
		state = true
		activated.emit()
		
#	If hit with water, check if already doused, if not, douse and emit 'doused' signal.
func deactivateTrigger():
	if (state):
		state = false
		deactivated.emit()

#	On collision (layer 4), check if object is in an activating or deactivating group
func _on_area_entered(area: Area2D):
	for group in activateGroups:
		if (area.is_in_group(group)):
			activateTrigger()
			return
	for group in deactivateGroups:
		if (area.is_in_group(group)):
			deactivateTrigger()
			return
			
func _on_body_entered(body: Node):
	for group in activateGroups:
		if (body.is_in_group(group)):
			activateTrigger()
			return
	for group in deactivateGroups:
		if (body.is_in_group(group)):
			deactivateTrigger()
			return

func _on_body_exited(body: Node):
	for group in activateGroups:
		if (body.is_in_group(group)):
			deactivateTrigger()
			return
