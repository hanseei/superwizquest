extends Area2D

func _on_body_entered(_body: Node):
	get_tree().call_group("UI","setText",$RichTextLabel.text)
	get_tree().call_group("UI","toggleTextboxVisible",true)
	#print("Scream!")

func _on_body_exited(_body: Node):
	get_tree().call_group("UI","toggleTextboxVisible",false)
