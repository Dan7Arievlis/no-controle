class_name Dash
extends Node

var player: Player
var dash_stats : DashResource

var can_dash: bool = true
var on_cooldown: bool = false
var has_dashed: bool = false
var dash_direction: Vector2 = Vector2.RIGHT
var last_x_direction: float = 1.0


func _init(_player: Player):
	player = _player
	dash_stats = _player.dash_stats


func handle_dash(_delta: float):
	if (has_dashed and not player.is_on_floor()) or on_cooldown:
		can_dash = false
	if player.is_on_floor() and not on_cooldown:
		can_dash = true
		has_dashed = false
	
	var dash_vector: Vector2 = get_dash_vector()
	if player.is_wall_sliding:
		has_dashed = false
		can_dash = true
	if Input.is_action_just_pressed("dash") and dash_vector and can_dash:
		dash(dash_vector)


func get_dash_vector() -> Vector2:
	var vertical_direction := 0.0
	if Input.get_axis("move_up", "move_down"):
		vertical_direction = Input.get_axis("move_up", "move_down")
	if not dash_stats.one_directional_dash:
		dash_direction = Vector2(player.input_direction, vertical_direction)
	if player.input_direction:
		last_x_direction = player.input_direction
		dash_direction.x = last_x_direction
	elif not vertical_direction and not dash_stats.one_directional_dash:
		dash_direction = Vector2(last_x_direction, 0)
	if not dash_stats.save_last_horizontal:
		dash_direction = Vector2(player.input_direction, vertical_direction)
		
	return dash_direction * dash_stats.dash_force


func dash(dash_vector: Vector2):
	# começo do dash
	can_dash = false
	player.is_dashing = true
	# aplicar velocidade
	if dash_vector.y:
		dash_vector.y *= 0.8
		dash_vector.x *= 0.8
	player.velocity = dash_vector
	#cancelar gravidade
	var gravity = player.local_gravity
	player.local_gravity = 0.0
	# permite apenas um dash no ar e recupera dash quando gruda em uma parede
	if not player.is_on_floor() and not player.is_wall_sliding:
		has_dashed = true
	# tempo de dash
	await player.get_tree().create_timer(dash_stats.dash_time).timeout
	player.is_dashing = false
	on_cooldown = true
	player.local_gravity = gravity
	# dash em cooldown
	await player.get_tree().create_timer(dash_stats.dash_cooldown).timeout
	can_dash = true
	on_cooldown = false
