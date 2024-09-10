class_name OneWayPlatform
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move_down") and Input.is_action_just_pressed("jump"):
		area_2d.set_deferred("monitoring", true)
	else:
		area_2d.set_deferred("monitoring", false)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.position.y += 2


func _on_area_2d_body_exited(body: Node2D) -> void:
	area_2d.set_deferred("monitoring", false)
