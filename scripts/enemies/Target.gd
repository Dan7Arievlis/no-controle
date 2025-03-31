extends RigidBody2D

signal on_enemy_death()

@export var enemy_stats : EnemyStats

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hurtbox: Hurtbox = $Hurtbox

func _ready() -> void:
	hurtbox.hurtbox_stats = HurtboxStats.new(enemy_stats.max_hp, enemy_stats.inmunity_frames)
	hurtbox.hp = hurtbox.hurtbox_stats.max_hp
