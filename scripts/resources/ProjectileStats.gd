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
@export var body_collision_layer : Array[int]
@export var body_collision_mask : Array[int]
@export var hitbox_collision_layer : Array[int]
@export var hitbox_collision_mask : Array[int]


func int_array_to_decimal(int_array):
	var decimal = 0
	for i in int_array:
		decimal += pow(2, (i - 1))
	return decimal
