extends Node2D

@onready var cannon: Node2D = $Cannon
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func _ready() -> void:
	animation_player.play("enemies.shooting_enemy/shoot")


func _on_cannon_can_shoot() -> void:
	#TODO animação para atirar
	animation_player.play("enemies.shooting_enemy/shoot")


func shoot():
	cannon.shoot(Vector2.RIGHT.rotated(cannon.global_rotation), cannon.global_rotation)


func _on_cannon_shot() -> void:
	#TODO outra animação
	pass
