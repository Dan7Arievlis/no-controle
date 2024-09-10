class_name Hitbox
extends Area2D

@export var hitbox_stats: HitboxStats
@export var collision_shape: Shape2D
@export var disabled = false : set = set_disabled


func _ready():
	$CollisionShape2D.shape = collision_shape


func set_disabled(value: bool):
	disabled = value
	$CollisionShape2D.set_deferred("disabled", value)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hittable"):
		var hurtbox = body.get_node("Hurtbox") as Hurtbox
		if hurtbox:
			hurtbox.add_hit(Hit.new(hitbox_stats.damage, get_parent(), body))


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Hittable"):
		var hurtbox = body.get_node("Hurtbox") as Hurtbox
		if hurtbox:
			hurtbox.remove_hit(get_parent())
