extends Node2D

@onready var player: Player
@onready var attack_pivot: MeleeAttack
@onready var cannon: Cannon = $Cannon
@onready var reload_timer: Timer = $Cannon/ReloadTimer

var shoot_buffer : float
var _auto_fire : bool
var ranged_attack_stats = RangedAttackResource


func new(_player : Player, _attack_pivot : MeleeAttack) -> void:
	player = _player
	attack_pivot = _attack_pivot
	ranged_attack_stats = player.stats.RANGED_ATTACK_STATS
	cannon.set_cannon(player.stats.PROJECTILE_STATS, player.stats.CANNON_STATS)


func _unhandled_input(event: InputEvent) -> void:
	if not is_instance_of(ranged_attack_stats, RangedAttackResource): return
	if event is InputEventKey:
		if ranged_attack_stats.enable_ranged_attack:
			if event.pressed and Input.is_action_just_pressed("ranged_atk") and not player.is_hurt and not player.is_dead:
				if reload_timer.time_left <= shoot_buffer and not reload_timer.is_stopped():
					_auto_fire = true
				if cannon.can_shoot:
					shoot()


func shoot():
	cannon.can_shoot = false
	if player.is_wall_sliding:
		attack_pivot.scale.x *= -1
	
	var direction := get_shot_vector() * attack_pivot.scale
	cannon.shoot(direction, 0.0)
 

func get_shot_vector() -> Vector2:
	var shot_direction = Vector2.RIGHT
	var vertical_direction := 0.0
	if Input.get_axis("move_up", "move_down"):
		vertical_direction = Input.get_axis("move_up", "move_down")
	if vertical_direction != 0 and (ranged_attack_stats._4_directions or ranged_attack_stats._8_directions):
		shot_direction = Vector2(0, vertical_direction)
		if ranged_attack_stats._8_directions:
			shot_direction.x += Input.get_axis("move_left", "move_right")
			shot_direction = shot_direction.normalized()
	
	shot_direction.x = abs(shot_direction.x)
	return shot_direction


func on_cannon_shot():
	if player.is_on_floor() and abs(player.velocity.x) < 2:
		player.velocity.x -= cannon.cannon_stats.recoil * attack_pivot.scale.x


func on_cannon_can_shoot():
	if _auto_fire:
		_auto_fire = false
		shoot()
