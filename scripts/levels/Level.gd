extends Node2D

# Level.gd
func _ready() -> void:
	var current_stats = SavedResources.current_stats.duplicate(true)
	$Player.stats = current_stats
	$PauseMenu.stats = current_stats
	get_tree().call_group("Projectile", "queue_free")
	get_tree().call_group("Animation Effect", "queue_free")
