class_name WallSlide
extends Node

var player: Player
var wall_slide_stats : WallSlideResource


func _init(_player: Player):
	player = _player
	wall_slide_stats = _player.wall_slide_stats


func handle_wall_slide(delta: float):
	if player.can_slide:
		wall_slide(delta)


func get_facing_direction():
	if player.velocity.x > 0:
		return Input.is_action_pressed("move_right")
	elif player.velocity.x < 0:
		return Input.is_action_pressed("move_left")
	return false

func wall_slide(delta: float):
	var facing_direction: bool
	facing_direction = get_facing_direction()
	
	player.is_wall_sliding = player.is_on_wall_only() and facing_direction and \
		player.can_slide and player.velocity.y > 0.0
	
	if player.is_wall_sliding:
		player.velocity.y = lerp(clamp(player.velocity.y, 0.0, wall_slide_stats.max_wall_slide_velocity), \
			wall_slide_stats.max_wall_slide_velocity, wall_slide_stats.wall_friction * delta)
		player.velocity.y = min(player.velocity.y, wall_slide_stats.max_wall_slide_velocity)
