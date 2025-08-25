extends CanvasLayer

var timerUp = false

func _ready() -> void:
	$TutorialBox.visible = true
	await get_tree().create_timer(2).timeout
	timerUp = true

func _input(_event):
	if (timerUp):
		$TutorialBox.visible = false

func setText(text: String):
	$DialogueBox/DialogueText.text = text
	
func toggleTextboxVisible(vis: bool):
	$DialogueBox.visible = vis
