extends RigidBody2D

@export var enemy_stats : EnemyStats

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wall_check: RayCast2D = $Pivot/WallCheck
@onready var fall_check: ShapeCast2D = $Pivot/FallCheck
@onready var floor_check: ShapeCast2D = $FloorCheck
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Hitbox = $Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var pivot: Node2D = $Pivot

var direction = Vector2.RIGHT


func _ready() -> void:
	hitbox.hitbox_stats = HitboxStats.new(enemy_stats.damage, enemy_stats.knockback_force)
	hurtbox.hurtbox_stats = HurtboxStats.new(enemy_stats.max_hp, enemy_stats.inmunity_frames)
	hurtbox.hp = hurtbox.hurtbox_stats.max_hp
	_walk()

func _physics_process(delta: float) -> void:
	if not floor_check.is_colliding():
		return
	if not hurtbox.disabled:
		if wall_check.is_colliding() or not fall_check.is_colliding():
			sprite_2d.flip_h = not sprite_2d.flip_h
			direction.x *= -1
			pivot.scale.x = direction.x
	
		linear_velocity = direction * enemy_stats.speed * delta
		move_and_collide(linear_velocity)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hittable"):
		apply_impulse(hitbox.hitbox_stats.knockback_force * -direction / 2)
		body.velocity = (Vector2(hitbox.hitbox_stats.knockback_force * -cos(body.get_angle_to(position)), hitbox.hitbox_stats.knockback_force * -sin(body.get_angle_to(position))))


func _walk():
	animation_player.play("enemies.walking_enemy/walk")


func _on_hurtbox_body_entered(body: Node2D) -> void:
	animation_player.play("enemies.walking_enemy/hurt")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	animation_player.play("enemies.walking_enemy/hurt")
