class_name WallClimb
extends Node

var player: Player

var is_climbing: bool
var climb_direction: Vector2
var climb_speed: float = 300.0
var climb_jump_impulse: Vector2
var stamina: float
var facing_direction: bool

var wall_climb_stats : WallClimbResource

func _init(_player: Player):
	player = _player


func handle_wall_climb(_delta: float):
	if not (wall_climb_stats and wall_climb_stats.enable_wall_climb): return
	is_climbing = Input.is_action_pressed("climb")
	if player.is_on_wall() and is_climbing:
		var vertical_move = Input.get_axis("move_up", "move_down")
		player.velocity.y = vertical_move * climb_speed
