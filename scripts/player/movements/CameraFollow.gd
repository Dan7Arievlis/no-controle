class_name CameraFollow
extends RemoteTransform2D

signal camera_ready(camera_follow: CameraFollow)

@onready var clamp_area: CollisionShape2D = $ClampArea/ViewBox
#@onready var clamp: Area2D = $Clamp


var player: Player : 
	set(_player):
		player = _player
		camera_stats = _player.stats.CAMERA_STATS
var camera_stats : CameraResource
var last_floor_height: float = 0.0
var focus_player: bool = false
var current_floor: float = 0.0
var change_damping: bool = false
var looking_around: bool = false
var clamping : bool = false

var wall_direction: int


func _ready():
	camera_ready.emit(self)

func _physics_process(delta):
	if not player or not player.stats: return
	_look_ahead(delta)
	_vertical_follow(delta)
	
	_look_around(delta)


func _look_ahead(delta: float):
	var size: Vector2 = clamp_area.get_shape().size / 2
	if player.velocity.x > 0:
		wall_direction = -1
	elif player.velocity.x < 0:
		wall_direction = 1
	
	if player.wall_jumping_timer <= -0.60 or not player.stats.WALL_JUMP_STATS.enable_wall_jump: #or player.is_on_floor():
	#if abs(player.velocity.x) > player.camera_follow_threshold:
		if camera_stats.increase_with_speed:
			position.x = lerpf(position.x, clamp(camera_stats.look_ahead.x * player.input_direction * \
				(abs(player.velocity.x) / player.stats.MOVEMENT_STATS.walk_speed), -size.x, size.x), camera_stats.damping.x * delta)
		else:
			position.x = lerpf(position.x, clamp(camera_stats.look_ahead.x * player.input_direction, \
				-size.x, size.x), camera_stats.damping.x * delta)
	else:
		#var direction = sign(player.velocity.x)
		if player.is_wall_sliding and player.is_on_wall():
			position.x = lerpf(position.x, size.x * wall_direction, camera_stats.damping.x * delta)


func _vertical_follow(delta: float):
	var size: Vector2 = clamp_area.get_shape().size / 2
	# velocidade da câmera reduzida para plataformas em alturas diferentes
	if not change_damping or current_floor != last_floor_height:
		change_damping = false
		global_position.y = lerpf(global_position.y, last_floor_height, camera_stats.damping.y * delta)
		# Altura da câmera e do chão nivelados
		if abs(last_floor_height - global_position.y) < 1:
			change_damping = true
	if player.is_on_floor():
		current_floor = roundi(last_floor_height)
		last_floor_height = roundi(player.global_position.y - camera_stats.floor_level_offset)
		if current_floor == last_floor_height and change_damping:
			if not looking_around:
				global_position.y = lerpf(global_position.y, last_floor_height, 10 * camera_stats.damping.y * delta)
			else:
				global_position.y = lerpf(global_position.y, last_floor_height, camera_stats.damping.y * delta)
		focus_player = false
	else:
		if focus_player:
			global_position.y = lerpf(global_position.y, player.global_position.y - \
				camera_stats.floor_level_offset, camera_stats.damping.y * delta)
			if player.velocity.y >= 0.0:
				position.y = lerpf(position.y, clamp(camera_stats.look_ahead.y * (player.velocity.y \
					/ player.stats.JUMP_STATS.max_fall_speed), -size.y, size.y), camera_stats.damping.y * delta)
		elif abs(global_position.y - player.position.y) > size.y:
			focus_player = true
		elif abs(global_position.x - player.position.x) > size.x:
			focus_player = false
		elif camera_stats.stable_floor and not focus_player:
			global_position.y = move_toward(global_position.y, last_floor_height, 75 * camera_stats.damping.y * delta)


func _look_around(delta: float):
	if player.input_direction == 0.0:
		looking_around = Input.is_action_pressed("look_down") or Input.is_action_pressed("look_up")
		var look_dir = int(Input.is_action_pressed("look_down")) - int(Input.is_action_pressed("look_up"))
		position.y = lerpf(position.y, position.y + look_dir * camera_stats.look_around_amount, camera_stats.damping.y * delta)
		
		if Input.is_action_just_released("look_down") or Input.is_action_just_released("look_up"):
			await get_tree().create_timer(0.7).timeout
			looking_around = false


func _on_clamp_camera_camera_clamped(_position: Vector2) -> void:
	if _position != Vector2.ZERO:
		position += _position
