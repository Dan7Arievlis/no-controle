extends Area2D

signal respawn_point_updated(point : Vector2)
@onready var respawn_point: Marker2D = $RespawnPoint


func _ready() -> void:
	respawn_point_updated.connect(get_parent().set_respawn_point.bind(respawn_point.global_position))


func _on_body_entered(body: Node2D) -> void:
	respawn_point_updated.emit()
