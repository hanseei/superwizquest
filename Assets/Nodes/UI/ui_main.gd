extends CanvasLayer

func setText(text: String):
	$DialogueBox/DialogueText.text = text
	
func toggleTextboxVisible(vis: bool):
	$DialogueBox.visible = vis
