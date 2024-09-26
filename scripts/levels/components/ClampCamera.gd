extends Node2D

signal camera_clamped(position : Vector2)

@onready var ray_cast_nw: RayCast2D = $RayCastNW
@onready var ray_cast_ne: RayCast2D = $RayCastNE
@onready var ray_cast_se: RayCast2D = $RayCastSE
@onready var ray_cast_sw: RayCast2D = $RayCastSW
@onready var camera_follow: CameraFollow = $".."
@onready var collision_shape_2d: CollisionShape2D = $Clamp/CollisionShape2D

func _process(_delta: float) -> void:
	var size: Vector2 = collision_shape_2d.get_shape().size / 2
	var target_position = Vector2.ZERO
	var candidate_target_1 : float
	var candidate_target_2 : float
	
	# DIREITA
	if (ray_cast_nw.is_colliding() and ray_cast_sw.is_colliding()):
		if ray_cast_nw.is_colliding():
			candidate_target_1 = -(camera_follow.global_position.x - (ray_cast_nw.get_collision_point().x + size.x))
		if ray_cast_sw.is_colliding():
			candidate_target_2 = -(camera_follow.global_position.x - (ray_cast_sw.get_collision_point().x + size.x))
		target_position.x = minf(candidate_target_1, candidate_target_2)
	# ESQUERDA
	elif ray_cast_ne.is_colliding() and ray_cast_se.is_colliding():
		if ray_cast_ne.is_colliding():
			candidate_target_1 = -(camera_follow.global_position.x - (ray_cast_ne.get_collision_point().x - size.x)) 
		if ray_cast_se.is_colliding():
			candidate_target_2 = -(camera_follow.global_position.x - (ray_cast_se.get_collision_point().x - size.x))
		target_position.x = maxf(candidate_target_1, candidate_target_2)
		
	# BAIXO
	if ray_cast_nw.is_colliding() and ray_cast_ne.is_colliding():
		if ray_cast_nw.is_colliding():
			candidate_target_1 = -(camera_follow.global_position.y - (ray_cast_nw.get_collision_point().y + size.y))
		if ray_cast_ne.is_colliding():
			candidate_target_2 = -camera_follow.global_position.y - (ray_cast_ne.get_collision_point().y + size.y)
		target_position.y = minf(candidate_target_1, candidate_target_2)
	# CIMA
	if ray_cast_sw.is_colliding() and ray_cast_se.is_colliding():
		if ray_cast_sw.is_colliding():
			candidate_target_1 = -(camera_follow.global_position.y - (ray_cast_sw.get_collision_point().y - size.y))
		if ray_cast_se.is_colliding():
			candidate_target_2 = -(camera_follow.global_position.y - (ray_cast_se.get_collision_point().y - size.y))
		target_position.y = maxf(candidate_target_1, candidate_target_2)
	
	if not target_position == Vector2.ZERO:
		camera_clamped.emit(target_position)
