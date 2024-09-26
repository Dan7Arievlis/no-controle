extends Node2D

signal on_can_shoot()
signal on_cannon_shot()

@onready var projectile_spawner: Node2D = $ProjectileSpawner
@onready var reload_timer: Timer = $ReloadTimer

var can_shoot : bool
var ammo : int


func set_cannon(projectile_stats, cannon_stats) -> void:
	projectile_spawner.projectile_stats = projectile_stats
	projectile_spawner.shot_effect = cannon_stats.shot_effect
	reload_timer.wait_time = cannon_stats.reload_time
	ammo = cannon_stats.max_ammo


func _on_reload_timer_timeout() -> void:
	can_shoot = true
	on_can_shoot.emit()


func shoot(direction : Vector2, effect_rotation : float):
	can_shoot = false
	if ammo == 0:
		return
	else:
		projectile_spawner.shoot(direction, effect_rotation)
		reload_timer.start()
		on_cannon_shot.emit()
		if ammo > 0:
			ammo -= 1
