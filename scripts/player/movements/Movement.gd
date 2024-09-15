class_name Movement

var player : Player
var movement_stats : MovementResource

var max_speed: float


func _init(_player: Player):
	player = _player
	movement_stats = _player.stats.MOVEMENT_STATS


func handle_movement(delta: float):
	if not player.is_hurt:
		if movement_stats and movement_stats.enable_movement: 
			player.input_direction = Input.get_axis("move_left", "move_right")
		else:
			player.input_direction = 0
	else:
		player.input_direction = 0
	max_speed = movement_stats.run_speed if Input.is_action_pressed("run") and movement_stats.can_run else movement_stats.walk_speed
	if player.is_in_apex:
		max_speed *= player.stats.JUMP_STATS.apex_speed_multiplier
	
	#if not player.is_dashing:
	if player.velocity.x > movement_stats.run_speed:
		_handle_air_state(movement_stats.turn_speed, movement_stats.air_turn_speed, player.input_direction, max_speed, movement_stats.accel_rate, movement_stats.high_speed_decel, movement_stats.air_accel_rate, movement_stats.air_high_speed_decel, delta)
	else:
		_handle_air_state(movement_stats.turn_speed, movement_stats.air_turn_speed, player.input_direction, max_speed, movement_stats.accel_rate, movement_stats.decel_rate, movement_stats.air_accel_rate, movement_stats.air_decel_rate, delta)
	#else:
		#_handle_turn(player.dash_control, player.input_direction, max_speed, player.dash_control, player.dash_control, delta)


func _handle_air_state(turn: float, air_turn: float, direction: float, speed: float, accel: float, decel: float, air_accel: float, air_decel: float, delta: float):
	if player.is_on_floor():
		_handle_turn(turn, direction, speed, accel, decel, delta)
	else:
		_handle_turn(air_turn, direction, speed, air_accel, air_decel, delta)


func _handle_turn(turn: float, direction: float, speed: float, accel: float, decel: float, delta: float):
	if not player.is_dashing:
		if direction * player.velocity.x >= 0:
			_speed_acceleration(direction, speed, accel, decel, delta)
		elif direction * player.velocity.x < 0:
			player.velocity = player.velocity.lerp(Vector2(direction * speed, player.velocity.y), turn * delta)


func _speed_acceleration(direction: float, speed: float, accel: float, decel: float, delta: float):
	if direction:
		if abs(player.velocity.x) != speed:
			player.velocity = player.velocity.lerp(Vector2(direction * speed, player.velocity.y), accel * delta) #move_toward(velocity.x, 0, speed)
		else:
			player.velocity.x = direction * speed
	else:
		player.velocity = player.velocity.lerp(Vector2(0, player.velocity.y), decel * delta) #move_toward(velocity.x, 0, speed)
