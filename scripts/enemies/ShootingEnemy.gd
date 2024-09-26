extends RigidBody2D

@export_range(0,1) var cannon_rotation := 0.0
@export var projectile_stats : ProjectileStats
@export var cannon_stats : CannonStats

@onready var hitbox: Hitbox = $Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var _initial_position : Vector2 = global_position
@onready var cannon: Node2D = $Sprite2D/ShootControl/Cannon

func _ready() -> void:
	sprite_2d.rotate(2 * PI * cannon_rotation)
	cannon.set_cannon(projectile_stats, cannon_stats)


func _physics_process(_delta: float) -> void:
	global_position = _initial_position
