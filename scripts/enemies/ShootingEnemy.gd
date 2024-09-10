extends RigidBody2D

@onready var hitbox: Hitbox = $Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var _initial_position : Vector2 = global_position


func _physics_process(delta: float) -> void:
	global_position = _initial_position
