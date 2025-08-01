extends Interactable

func _ready():
	activateGroups = ["waters"]

func _on_bucket_activated():
	$AnimatedSprite2D.animation = "fill"
