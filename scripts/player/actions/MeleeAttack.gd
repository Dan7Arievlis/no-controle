class_name MeleeAttack
extends Node2D

@onready var player: Player
@onready var swing_cooldown : Timer = $AtkCooldown

@onready var side_swing: Area2D = $SideHitbox
@onready var up_swing: Area2D = $UpHitbox
@onready var down_swing: Area2D = $DownHitbox
@onready var attack_animation_player: AnimationPlayer = $"../AttackAnimationPlayer"

#TODO mudar swing time para um sinal no final da animnação de ataque
var _can_swing: bool = true
var _auto_swing: bool
var _atk_hitbox : Hitbox
var melee_attack_stats : MeleeAttackResource


func new(_player : Player) -> void:
	player = _player
	melee_attack_stats = player.stats.MELEE_ATTACK_STATS
	swing_cooldown.wait_time = melee_attack_stats.swing_cooldown
	
	side_swing.hitbox_stats = player.stats.MELEE_HITBOX_STATS
	down_swing.hitbox_stats = player.stats.MELEE_HITBOX_STATS
	up_swing.hitbox_stats  =  player.stats.MELEE_HITBOX_STATS

	side_swing.hide()
	down_swing.hide()
	up_swing.hide()


func _unhandled_input(event: InputEvent) -> void:
	if not melee_attack_stats: return
	if event is InputEventKey:
		if event.pressed and Input.is_action_just_pressed("melee_atk") and melee_attack_stats.enable_melee_attack and not player.is_hurt and not player.is_dead:
			if swing_cooldown.time_left <= melee_attack_stats.swing_buffer and not swing_cooldown.is_stopped():
				_auto_swing = true
			if _can_swing:
				_attack()


func _attack():
	_can_swing = false
	
	if Input.is_action_pressed("move_up"):
		_atk_hitbox = up_swing
		attack_animation_player.play("player_attacks/up_attack_animation")
	elif Input.is_action_pressed("move_down") and not player.is_on_floor():
		_atk_hitbox = down_swing
		attack_animation_player.play("player_attacks/down_attack_animation")
	else:
		_atk_hitbox = side_swing
		attack_animation_player.play("player_attacks/side_attack_animation")
	
	
	#_swing()
	swing_cooldown.start()


func _swing():
	player.is_attacking = true
	if player.is_wall_sliding:
		scale.x *= -1
	
	_atk_hitbox.set_disabled(false)
	_atk_hitbox.show()
	
	if _atk_hitbox == side_swing and player.is_on_floor() and abs(player.velocity.x) < 2:
		player.velocity.x -= (melee_attack_stats.swing_recoil * scale.x)


func stop_attack():
	_atk_hitbox.set_disabled(true)
	_atk_hitbox.hide()
	player.is_attacking = false


func _on_atk_cooldown_timeout() -> void:
	_can_swing = true
	if _auto_swing:
		_attack()
		_auto_swing = false


func _on_side_swing_body_entered(body: Node2D) -> void:
	# hack solve
	player.velocity.x -= melee_attack_stats.strike_recoil * scale.x
	if body.is_in_group("Enemy"):
		#TODO se quiser trocar o knockback da espada é aqui
		body.apply_impulse(Vector2(side_swing.hitbox_stats.knockback_force * scale.x, -side_swing.hitbox_stats.knockback_force / 2)) #side_swing.hitbox_stats.knockback_force * sin(body.get_angle_to(player.position)) * 2))


func _on_up_swing_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.apply_impulse(Vector2(up_swing.hitbox_stats.knockback_force * sin(body.get_angle_to(player.attack_pivot.position)), -up_swing.hitbox_stats.knockback_force))


func _on_down_swing_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		player.velocity.y = -melee_attack_stats.strike_recoil * 3
	if body.is_in_group("Pogo"):
		player.local_gravity = player.gravity
		player.velocity.y = -melee_attack_stats.pogo_force
		player.dash.can_dash = true
		player.dash.has_dashed = false
		return
	elif not body.is_in_group("Terrain"):
		body.apply_impulse(Vector2(down_swing.hitbox_stats.knockback_force * sin(body.get_angle_to(player.attack_pivot.position)), down_swing.hitbox_stats.knockback_force))
	else:
		if player.velocity.y > 0:
			player.velocity.y = -melee_attack_stats.strike_recoil
