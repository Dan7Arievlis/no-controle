class_name JumpResource
extends Resource

@export_group("Jump")
@export var enable_jump: bool = true 
@export_subgroup("Impulses")
@export var jump_velocity := 400.0 # pixels
# Get the gravity from the project settings to be synced with RigidBody nodes.

@export_subgroup("Falling")
@export var max_fall_speed: float = 700.0

@export_subgroup("Gravity Modifiers")
@export_range(1, 10) var gravity_fall_multiplier: float = 1.5
@export_range(0, 1) var jump_cut_multiplier: float = 0.5

@export_subgroup("Apex")
@export_range(1, 10) var gravity_apex_multiplier: float = 1.2
@export_range(1, 10) var apex_speed_multiplier: float = 1.2
@export var apex_margin: float = 10.0

@export_subgroup("Coyote Time and Time Buffer")
@export var coyote_time: float = 0.2
@export var jump_buffer: float = 0.3

@export_subgroup("Double Jump")
@export var double_jump: bool = false
@export var double_jump_velocity := 300.0 # pixels
@export var jump_wait: float = 0.1
