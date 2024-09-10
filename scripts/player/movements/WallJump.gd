class_name WallJump
extends Node

var player: Player
var wall_jump_stats : WallJumpResource

var just_sliding = false


func _init(_player: Player):
	player = _player
	wall_jump_stats = _player.wall_jump_stats


func handle_wall_jump(delta: float):
	wall_jump(delta)


func wall_jump(delta: float):
	var direction = sign(player.velocity.x)
	
	if player.is_wall_sliding:
		player.wall_jumping_timer = wall_jump_stats.wall_jumping_grace_time
	else:
		player.wall_jumping_timer -= delta
	 
	if player.wall_jumping_timer > 0.0 and Input.is_action_just_pressed("jump"):
		var wall_direction = -1.0 if player.is_on_wall() else wall_jump_stats.jump_off_wall_multiplier
		player.velocity = Vector2(wall_jump_stats.wall_jump_vector.x * direction * wall_direction, -wall_jump_stats.wall_jump_vector.y)
		player.wall_jumping_timer = 0.0
