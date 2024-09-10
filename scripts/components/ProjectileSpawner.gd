extends Node2D

@onready var root = get_tree().get_root()
@onready var shot_effect_scene : PackedScene = load("res://scenes/effects/effect_animation.tscn")

var projectile_scene : PackedScene = load("res://scenes/projectiles/projectile.tscn")
var projectile_stats : ProjectileStats
var _current_projectile : Projectile
var shot_effect : EffectResource
var effects_material : Material


func shoot(direction : Vector2, effect_rotation : float):
	_current_projectile = projectile_scene.instantiate()
	_current_projectile.projectile_stats = projectile_stats
	_current_projectile.direction = direction
	_current_projectile.position = global_position
	spawn_effect(direction, effect_rotation)


func spawn_effect(direction : Vector2, effect_rotation : float):
	if shot_effect:
		shot_effect_scene.instantiate().spawn_effect(shot_effect, global_position, root, projectile_stats.effects_material, effect_rotation, (direction.x) < 0, abs(rad_to_deg(effect_rotation)) > 90)
	root.call_deferred("add_child", _current_projectile)


func on_shoot_projectile():
	pass
