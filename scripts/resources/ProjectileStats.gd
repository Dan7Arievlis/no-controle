class_name ProjectileStats
extends Resource

@export_group("Projectile")
@export var life_time : float = 0.6
@export var life : int = 1
@export var damage : float = 1.0
@export var speed : float = 450.0
@export var gravity : float = 0.0
@export var knockback_force : float = 250.0
@export_group("Effects")
@export var travel_animation : EffectResource
@export var hit_effect : EffectResource
@export var destroy_effect : EffectResource
@export var projectile_material : Material
@export var effects_material : Material
@export_group("Collision")
@export_flags_2d_physics var body_collision_layer = 0
@export_flags_2d_physics var body_collision_mask = 0
@export_flags_2d_physics var hitbox_collision_layer = 0
@export_flags_2d_physics var hitbox_collision_mask = 0
