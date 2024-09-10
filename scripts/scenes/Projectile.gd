class_name Projectile
extends RigidBody2D

@onready var projectile_animation: AnimationPlayer = $ProjectileAnimation
@onready var time_to_live: Timer = $TimeToLive
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var root = get_tree().get_root()
@onready var effect_scene : PackedScene = load("res://scenes/effects/effect_animation.tscn")

@export var projectile_stats : ProjectileStats
@export var hittable : bool : set = set_hittable

var projectile_life : int
var direction : Vector2
var hitbox : HitboxStats


func set_hittable(value : bool):
	if value:
		add_to_group("Hittable")
	else:
		remove_from_group("Hittable")


func _ready() -> void:
	$Hitbox.hitbox_stats = HitboxStats.new(projectile_stats.damage, projectile_stats.knockback_force)
	$Hitbox/CollisionShape2D.shape = $CollisionShape2D.shape
	hitbox = $Hitbox.hitbox_stats
	
	collision_layer = projectile_stats.int_array_to_decimal(projectile_stats.body_collision_layer)
	collision_mask = projectile_stats.int_array_to_decimal(projectile_stats.body_collision_mask)
	$Hitbox.collision_layer = projectile_stats.int_array_to_decimal(projectile_stats.hitbox_collision_layer)
	$Hitbox.collision_mask = projectile_stats.int_array_to_decimal(projectile_stats.hitbox_collision_mask)
	
	$Sprite2D.flip_h = sign(direction.x) < 0
	#$Sprite2D.flip_v = sign(direction.y) < 0
	gravity_scale = projectile_stats.gravity
	projectile_life = projectile_stats.life
	time_to_live.wait_time = projectile_stats.life_time
	time_to_live.start()
	material = projectile_stats.projectile_material
	projectile_animation.play("projectiles/" + projectile_stats.travel_animation.animation.resource_name)
	apply_impulse(direction * projectile_stats.speed)


func _process(_delta: float) -> void:
	sprite_2d.rotation = linear_velocity.angle()
	if abs(sprite_2d.rotation_degrees) >= 90:
		sprite_2d.rotation += PI
		sprite_2d.flip_v = false
		sprite_2d.flip_h = true


func spawn_effect(effect_resource : EffectResource, effect_rotation : float):
	effect_scene.instantiate().spawn_effect(effect_resource, global_position, root, projectile_stats.effects_material, effect_rotation, (direction.x) < 0)


func _hit():
	var rotate = linear_velocity.angle()
	if abs(rad_to_deg(rotate)) > 90:
		rotate += PI
	spawn_effect(projectile_stats.hit_effect, rotate) #projectile_stats.hit_effect.instantiate()


func _destroy():
	spawn_effect(projectile_stats.destroy_effect, 0.0) #projectile_stats.hit_effect.instantiate()
	queue_free()


func _on_time_to_live_timeout() -> void:
	_destroy()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hittable"):
		projectile_life -= 1
		if projectile_life <= 0:
			queue_free()
	if body.is_in_group("Player"):
		body.velocity = (Vector2(hitbox.knockback_force * sign(direction.x), -hitbox.knockback_force / 2))
	if body.is_in_group("Enemy"):
		body.apply_impulse(Vector2(hitbox.knockback_force * sign(direction.x), -hitbox.knockback_force / 2))
	if body.is_in_group("Terrain"):
		_destroy()
		return
	_hit()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Blocker"):
		collision_mask = area.collision_mask
		collision_layer = area.collision_layer
		linear_velocity *= -1
	_hit()
