extends Node

@export var spawn_point_node: NodePath

@onready var spawn_point = get_node("/root/TestStage/SpawnPointPlayer1")

var wind_timer = 4
var global_direction = Vector2.ZERO
var global_z_speed = 0
var global_x_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if has_node(spawn_point_node):
		spawn_point = get_node(spawn_point_node).global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func update_spawn():
	if get_node("/root/TestStage/torch1").state == true:
		spawn_point = get_node("/root/TestStage/SpawnPointPlayer2")
