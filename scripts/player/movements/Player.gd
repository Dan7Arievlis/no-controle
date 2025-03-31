class_name Player
extends CharacterBody2D

signal on_death
signal max_life_changed(value : float)
signal life_changed(value : float)

#region Movement
var input_direction: float
var time_moving: float
#endregion

#region Jump
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var local_gravity = gravity

var is_in_apex: bool : get = _is_in_apex

var is_on_air = false
#endregion

#region Wall Slide
var can_slide = true
#endregion

#region Wall Jump
var wall_jumping_timer: float = 0.0
var is_wall_sliding: bool = false
#endregion

#region Dash
var is_dashing: bool = false
#endregion

#region Melee Attack
var is_attacking: bool
#endregion

#region Ranged Attack
#endregion

@export_group("Camera Clamp Area")
@export var clamp_size := Vector2(190, 190) : set = set_camera_clamp_size
@export_group("Damage Tolerance")
@export_range(0, 1) var damage_movement_tolerance : float = 0.5
@export_group("Hit Points")
@export var max_hp : float

#region onready
@onready var sprite = $Sprite2D
@onready var off_air_tv: Sprite2D = $OffAirTV
@onready var attack_pivot = $AttackPivot
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var clamp_area: CollisionShape2D
@onready var ranged_attack_input: Node2D = $AttackPivot/RangedAttackInput
@onready var cannon: Node2D = $AttackPivot/RangedAttackInput/Cannon
#endregion

# Player.gd
#region Moveset
var movement : Movement
var jump : Jump
var dash : Dash
var wall_slide : WallSlide
var wall_jump : WallJump
var wall_climb : WallClimb
#endregion

var is_hurt : bool = false
var is_dead : bool = false
var stats : PlayerStats :
	set(_stats):
		stats = _stats
		if stats.MOVEMENT_STATS: movement = Movement.new(self)
		if stats.JUMP_STATS: jump = Jump.new(self)
		if stats.DASH_STATS: dash = Dash.new(self)
		if stats.WALL_SLIDE_STATS: wall_slide = WallSlide.new(self)
		if stats.WALL_JUMP_STATS: wall_jump = WallJump.new(self)
		if stats.WALL_SLIDE_STATS: wall_climb = WallClimb.new(self)
		if stats.MELEE_ATTACK_STATS: attack_pivot.new(self)
		if stats.RANGED_ATTACK_STATS: ranged_attack_input.new(self, attack_pivot)


func _ready():
	set_max_life()
	animation_tree.active = true
	animation_player.play("player/RESET")


func _process(delta):
	if not self.is_attacking:
		if input_direction > 0: #velocity.x > 0:
			sprite.flip_h = false
			attack_pivot.scale.x = 1
		elif input_direction < 0: #velocity.x < 0:
			sprite.flip_h = true
			attack_pivot.scale.x = -1
		off_air_tv.scale.x = attack_pivot.scale.x
		off_air_tv.flip_h = off_air_tv.scale.x < 0
	if abs(velocity.x) > 100.0:
		time_moving += delta
	
	_handle_animation()

# Player.gd
func _physics_process(delta):
	if is_dead: return
	if not stats: return
	movement.handle_movement(delta)
	
	var special_moveset = (is_dashing or is_wall_sliding or wall_jumping_timer > 0.0)
	if jump and not special_moveset:
		jump.handle_jump(delta)
	elif not special_moveset:
		velocity.y += gravity * delta
	
	if dash and not is_hurt: dash.handle_dash(delta)
	if wall_slide and not is_hurt: wall_slide.handle_wall_slide(delta)
	if wall_jump and not is_hurt: wall_jump.handle_wall_jump(delta)
	if wall_climb and not is_hurt: wall_climb.handle_wall_climb(delta)
	
	move_and_slide()


func set_max_life():
	call_deferred("_max_life_changed", max_hp)
	hurtbox.connect("got_hit", _life_changed.bind())
	hurtbox.hurtbox_stats.max_hp = max_hp
	hurtbox.hp = max_hp
	_life_changed(max_hp)


func _life_changed(hp : float):
	life_changed.emit(hp)


func _max_life_changed(hp : float):
	max_life_changed.emit(hp)


func set_camera_clamp_size(new_size: Vector2):
	if clamp_area:
		clamp_area.get_shape().size = new_size


func _handle_animation():
	# FIXME não é todo parametro q vai funcionar com os números fixos. Troca eles para variáveis 
	# exportadas ou crie alguma lógica par cada um associado a uma variável definida por usuário
	if is_dead:
		animation_tree.set("parameters/Hurt_Transition/transition_request", "dead") 
		return
	if is_hurt:
		animation_tree.set("parameters/Hurt_Transition/transition_request", "hurt") 
		return
	animation_tree.set("parameters/Hurt_Transition/transition_request", "movement") 
	if is_dashing:
		animation_tree.set("parameters/Movement/transition_request", "dash") 
		return
	if is_on_floor(): # no chão
		animation_tree.set("parameters/Movement/transition_request", "idle")
		if is_on_air and not input_direction:
			animation_tree.set("parameters/Idle_Transition/transition_request", "crash")
			#print("CRASH")
			await get_tree().create_timer(0.2).timeout
			is_on_air = false
		elif abs(velocity.x) < 10.0 and not input_direction: # não se move
			animation_tree.set("parameters/Idle_Transition/transition_request", "idle")
			time_moving = 0
			#print("IDLE")
		elif input_direction == 0 and abs(velocity.x) > 1.0 and time_moving > 1.0: # está desacelerando para 0m/s
			animation_tree.set("parameters/Idle_Transition/transition_request", "break")
			#print("BREAK")
		else: # se move
			animation_tree.set("parameters/Movement/transition_request", "move")
			if velocity.x * input_direction > 0: # se move na mesma direção do movimento
				if Input.is_action_pressed("run") and stats.MOVEMENT_STATS.can_run: # corre
					animation_tree.set("parameters/Movement_Transition/transition_request", "run")
					#print("RUN")
				else: # anda
					animation_tree.set("parameters/Movement_Transition/transition_request", "walk")
					#print("WALK")
			elif velocity.x * input_direction < 0 and abs(velocity.x) > 70.0: # se move na direção contrária ao movimento
				animation_tree.set("parameters/Movement_Transition/transition_request", "slide")
				#print("SLIDE")
	else:
		animation_tree.set("parameters/Movement/transition_request", "air")
		is_on_air = true
		if is_wall_sliding:
			animation_tree.set("parameters/Jump/transition_request", "wall_slide")
			#print("WALL SLIDE")
			return
		if is_in_apex:
			animation_tree.set("parameters/Jump/transition_request", "apex")
			#print("APEX")
		elif velocity.y <  0.0:
			animation_tree.set("parameters/Jump/transition_request", "start")
			#print("START")
		elif velocity.y > 0.0:
			animation_tree.set("parameters/Jump/transition_request", "fall")
			#print("FALL")


func _is_in_apex():
	return Input.is_action_pressed("jump") and not is_on_floor() and abs(velocity.y) <= stats.JUMP_STATS.apex_margin


func die():
	is_dead = true


func respawn():
	on_death.emit()


func _on_ray_casts_nudge_player(amount):
	if not is_on_floor():
		position += amount


func _on_camera_follow_camera_ready(camera_follow):
	await get_tree().create_timer(0.02).timeout
	camera_follow.player = self
	clamp_area = $CameraFollow/ClampArea/ViewBox


func _on_hurtbox_body_entered(body: Node2D) -> void:
	#TODO animação de hit
	if body.is_in_group("Target"): return
	is_hurt = true
	if body.is_in_group("Spikes"):
		velocity = (Vector2.UP * 300).rotated(body.get_angle_to(attack_pivot.position))
		await get_tree().create_timer(0.5).timeout
		if not is_dead:
			respawn()
	await get_tree().create_timer(hurtbox.hurtbox_stats.inmunity_frames * damage_movement_tolerance * get_physics_process_delta_time()).timeout
	is_hurt = false
