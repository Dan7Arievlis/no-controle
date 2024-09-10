extends Node2D

@onready var spawn_point: Node2D = $SpawnPoint


func _ready() -> void:
	$Player.position = spawn_point.position


func _on_area_2d_body_entered(_body):
	$Player.position = spawn_point.position
