extends RigidBody2D

@onready var hitbox : Area2D = $Hitbox


func _on_hitbox_body_entered(body: Node2D) -> void:
	apply_impulse(Vector2.LEFT * hitbox.hitbox_stats.knockback_force * scale.x)
	body.velocity = (Vector2(hitbox.hitbox_stats.knockback_force * scale.x, hitbox.hitbox_stats.knockback_force * cos(body.get_angle_to(position)) / 1.5))
