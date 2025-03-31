class_name Jump

var player: Player
var jump_stats : JumpResource

var _can_double_jump: bool = false
var _coyote_time_timer_alive: bool = false

var _coyote_time_timer: float = 0.0
var _jump_buffer_timer: float = 0.0


func _init(_player: Player):
	player = _player
	jump_stats = _player.stats.JUMP_STATS


func handle_jump(delta: float):
	_coyote_time(delta)
	_jump_buffer(delta)
	
	# pulo duplo
	if player.is_on_floor() and not Input.is_action_pressed("jump"):
		_can_double_jump = false

	# está no ápice do pulo
	if player.is_in_apex:
		player.local_gravity = player.gravity / jump_stats.gravity_apex_multiplier
	
	# pulou
	if not Input.is_action_pressed("move_down"):
		if Input.is_action_pressed("jump") and _jump_buffer_timer > 0.0 and _coyote_time_timer > 0.0 and not player.is_hurt:
			# ajusta a gravidade para não pular em alturas diferentes no coyote time
			_jump(jump_stats.jump_velocity)
		elif Input.is_action_just_pressed("jump") and _double_jump():
			if jump_stats.jump_wait > 0.0:
				await player.get_tree().create_timer(jump_stats.jump_wait).timeout
			_jump(jump_stats.double_jump_velocity)
		# Cortou o tamanho do pulo
		if Input.is_action_just_released("jump") and player.velocity.y < 0:
			player.velocity.y *= jump_stats.jump_cut_multiplier
			_coyote_time_timer = 0.0
		# está caindo
		if player.velocity.y > 0:
			player.local_gravity = player.gravity * jump_stats.gravity_fall_multiplier
		# está no chão
		if player.is_on_floor():
			player.local_gravity = player.gravity
	
	# está no ar
	if not player.is_on_floor():
		player.velocity.y += player.local_gravity * delta
		# limitar velocidade queda
		player.velocity.y = min(player.velocity.y, jump_stats.max_fall_speed)


func _coyote_time(delta: float):
	# Coyote Time
	if player.is_on_floor():
		_coyote_time_timer = jump_stats.coyote_time
		_coyote_time_timer_alive = true
	else:
		_coyote_time_timer -= delta
		# _coyote_time_timer_alive permite que o personagem possa executar o segundo pulo no ar 
		# independente de ter executado o primeiro uma vez que o coyote time tenha expirado
		if _coyote_time_timer_alive and _coyote_time_timer < 0.0:
			_coyote_time_timer_alive = false
			_can_double_jump = true


func _jump_buffer(delta: float):
	# Jump Buffer
	if Input.is_action_just_pressed("jump") and (jump_stats and jump_stats.enable_jump):
		_jump_buffer_timer = jump_stats.jump_buffer
	else:
		_jump_buffer_timer -= delta


func _jump(jump_velocity: float):
	player.local_gravity = player.gravity
	player.velocity.y = -jump_velocity 
	_jump_buffer_timer = 0.0
	
	_can_double_jump = false


func _double_jump():
	return jump_stats.double_jump and _can_double_jump
