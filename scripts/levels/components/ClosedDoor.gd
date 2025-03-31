extends RigidBody2D

var enemies_alive = []
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	var array = get_tree().get_nodes_in_group("Enemy")
	array.append_array(get_tree().get_nodes_in_group("Target"))
	for enemy in array:
		if enemy.has_signal("on_enemy_death"):
			enemy.connect("on_enemy_death", check_open.bind())
			enemies_alive.append(enemy)


func check_open():
	enemies_alive.pop_front()
	if enemies_alive.is_empty():
		animation_player.play("open")
