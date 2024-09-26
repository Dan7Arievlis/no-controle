class_name MovementResource
extends Resource

@export_group("Movement")
@export var enable_movement: bool = false

@export_subgroup("Acceleration")
@export_range(0.1, 20, 0.1) var accel_rate: float = 4.4 # pxl/s²
@export_range(0.1, 20, 0.1) var decel_rate: float = 4.4 # pxl/s²
#
@export_range(0.1, 20, 0.1) var air_accel_rate: float = 2.0 # pxl/s²
@export_range(0.1, 20, 0.1) var air_decel_rate: float = 3.0 # pxl/s²
#
@export_range(0.1, 20, 0.1) var high_speed_decel: float = 2.4 # pxl/s²
@export_range(0.1, 20, 0.1) var air_high_speed_decel: float = 2.4 # pxl/s²

@export_subgroup("Speed")
@export var walk_speed: float = 300.0 # pxl/s
@export var can_run: bool = false
@export var run_speed: float = 600.0 # pxl/s
#
@export_range(0.0, 20, 0.1) var turn_speed: float = 1.0 # pxl/s²
@export_range(0.0, 20, 0.1) var air_turn_speed: float = 1.0 # pxl/s²
