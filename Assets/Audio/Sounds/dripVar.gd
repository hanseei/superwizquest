extends AudioStreamPlayer

func _on_finished():
	pitch_scale = 2 - (randf() * 2)
	await get_tree().create_timer(randf()).timeout
	play()
