extends Area2D

@export var stageText: String
@export var nextStageName: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Gamecontroller.levelLoadPath = "res://Assets/Nodes/Scenes/" + nextStageName + ".tscn"
	Gamecontroller.title_screen_text = stageText
	get_tree().change_scene_to_file("res://Assets/Nodes/Scenes/level_title.tscn")
	Gamecontroller.respawn_counter = 0
