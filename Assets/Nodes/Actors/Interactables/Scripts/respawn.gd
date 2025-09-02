extends Area2D

var respawn_used = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@warning_ignore("unused_parameter")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	#print("player")
	if respawn_used == false:
		Gamecontroller.respawn_counter += 1
		respawn_used = true
	else:
		print(respawn_used)
