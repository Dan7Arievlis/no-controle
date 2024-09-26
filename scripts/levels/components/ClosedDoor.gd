extends RigidBody2D

var enemies_alive = []
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if enemy.has_signal("on_enemy_death"):
			enemy.connect("on_enemy_death", check_open.bind())
			print("Closed door connect: ", enemy)
			enemies_alive.append(enemy)


func check_open():
	print("Closed door check open")
	enemies_alive.pop_front()
	if enemies_alive.is_empty():
		animation_player.play("open")
