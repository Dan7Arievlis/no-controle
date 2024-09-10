class_name WallClimbResource
extends Resource

@export_group("Wall Climb")
@export var enable_wall_climb: bool = true : set = _set_wall_climb


func _set_wall_climb(value: bool):
	enable_wall_climb = value
	#if value:
		#enable_wall_jump = false
		#wall_jumping_timer = 0.0
	#else:
		#enable_wall_jump = true
