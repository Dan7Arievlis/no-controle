class_name HitboxStats
extends Resource

@export var damage: float
@export var knockback_force: float


func _init(_damage : float = 0, _knockback_force : float = 0) -> void:
	damage = _damage
	knockback_force = _knockback_force
