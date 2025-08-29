extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Start.grab_focus()
	Gamecontroller.title_screen_text = "LEVEL 1-1 - THE FALL"
	Gamecontroller.levelLoadPath = "res://Assets/Nodes/Scenes/intro_stage.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Nodes/Scenes/level_title.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
