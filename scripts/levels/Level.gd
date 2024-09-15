extends Node2D

func _ready() -> void:
	var current_stats = SavedResources.current_stats.duplicate(true)
	#var current_stats = load("res://resources/levels/current_level.tres").stats
	$Player.stats = current_stats
	$PauseMenu.stats = current_stats
