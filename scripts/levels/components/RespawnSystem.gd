extends Node2D

@onready var initial_spawn: Marker2D = $InitialSpawn
var respawn_point : Vector2
var player : Player

func _ready() -> void:
	respawn_point = initial_spawn.position
	player = get_parent().get_node("Player")
	player.on_death.connect(respawn_player.bind())
	respawn_player()

func set_respawn_point(point : Vector2):
	respawn_point = point


func respawn_player():
	player.velocity = Vector2.ZERO
	if player.is_dead:
		#FIXME adicionar menu de morte
		respawn_point = initial_spawn.position
		player.hurtbox.heal(100)
		player.is_dead = false
	player.global_position = respawn_point
