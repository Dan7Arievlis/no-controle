extends Hitbox

var entities_hitted : Array = []

func set_disabled(value: bool):
	super.set_disabled(value)
	if disabled:
		entities_hitted.clear()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hittable") and body not in entities_hitted:
		var hurtbox = body.get_node("Hurtbox") as Hurtbox
		if hurtbox:
			hurtbox.add_hit(Hit.new(hitbox_stats.damage, get_parent(), body))
			entities_hitted.append(body)
