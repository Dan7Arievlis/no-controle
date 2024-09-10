class_name MeleeAttackResource
extends Resource

@export_group("Melee Attack")
@export var enable_melee_attack: bool = true
@export var melee_damage: float
@export_subgroup("Timers")
@export var swing_time: float = 0.07
@export var swing_buffer: float = 0.08
@export var swing_cooldown: float = 0.5
@export_subgroup("Knockback")
@export var knockback_force: float = 400.0
@export var swing_recoil: float = 10.0
@export var strike_recoil: float = 100.0
@export var pogo_force: float = 400.0
