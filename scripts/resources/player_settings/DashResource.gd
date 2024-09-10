class_name DashResource
extends Resource

@export_group("Dash")
@export var enable_dash: bool = true
@export_subgroup("Impulse")
@export var dash_force: float = 300.0
@export_subgroup("Direction Controls")
@export var one_directional_dash: bool = false
@export var save_last_horizontal: bool = true
#@export_range(0.0, 10.0, 0.1) var dash_control: float = 1.0
@export_subgroup("Timers")
@export var dash_time := 0.2
@export var dash_cooldown := 0.2
