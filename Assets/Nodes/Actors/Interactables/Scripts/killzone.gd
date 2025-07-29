extends Area2D



func _on_body_entered(body: Node2D) -> void:
	print("Kill zone triggered by:", body)
	if body.has_method("respawn"):
		print("Calling respawn() on:", body.name)
		body.respawn()
	else:
		print(body.name, "has no respawn() method")
