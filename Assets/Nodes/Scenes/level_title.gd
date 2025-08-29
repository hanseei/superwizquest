extends Control

func _ready() -> void:
	$RichTextLabel.text = Gamecontroller.title_screen_text
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(Gamecontroller.levelLoadPath)
