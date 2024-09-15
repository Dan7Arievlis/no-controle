class_name WallJumpResource
extends Resource

@export_group("Wall Jump")
@export var enable_wall_jump: bool = false

@export var wall_jump_vector: Vector2 = Vector2(100, 400)
@export var wall_jumping_grace_time: float = 0.1
@export var jump_off_wall_multiplier: float = 1
