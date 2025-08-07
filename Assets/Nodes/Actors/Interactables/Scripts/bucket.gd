extends Interactable

func _ready():
	activateGroups = ["waters"]
	super._ready()

func _on_bucket_activated():
	$AnimatedSprite2D.animation = "fill"
	
