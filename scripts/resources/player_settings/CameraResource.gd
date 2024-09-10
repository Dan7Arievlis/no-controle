class_name CameraResource
extends Resource

@export_group("Camera")
@export var look_ahead: Vector2 = Vector2(48, 30)
@export var camera_follow_threshold: float = 110
@export var increase_with_speed: bool = true
@export var damping: Vector2 = Vector2(2, 6)
@export var floor_level_offset: float = 64.0
@export var stable_floor: bool = true
@export var look_around_amount = 128.0
