extends Node2D

@onready var death_menu: CanvasLayer = %DeathMenu
@onready var initial_spawn: Marker2D = $InitialSpawn
var respawn_point : Vector2
var player : Player

func _ready() -> void:
	respawn_point = initial_spawn.position
	player = get_parent().get_node("Player")
	player.on_death.connect(respawn_player.bind())
	death_menu.connect("respawn_signal", respawn.bind())
	respawn_player()


func set_respawn_point(point : Vector2):
	respawn_point = point


func respawn_player():
	player.velocity = Vector2.ZERO
	if player.is_dead:
		respawn_point = initial_spawn.position
		death_menu.show()
		return
	respawn()


func respawn():
	player.global_position = respawn_point
