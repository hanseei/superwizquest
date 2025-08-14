extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print("enemy triggered by:", body)
	if body.has_method("respawn"):
		print("Calling respawn() on:", body.name)
		body.respawn()
	else: 
		pass
