class_name Doorway
extends CharacterBody2D

signal exit_level()

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D
@onready var arrow: Sprite2D = $Arrow


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("move_up"):
		area_2d.set_deferred("monitoring", true)
	else:
		area_2d.set_deferred("monitoring", false)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	exit_level.emit()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	area_2d.set_deferred("monitoring", false)


func _on_render_area_area_entered(_area: Area2D) -> void:
	arrow.visible = true


func _on_render_area_area_exited(_area: Area2D) -> void:
	arrow.visible = false
