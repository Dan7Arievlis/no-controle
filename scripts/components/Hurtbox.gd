class_name Hurtbox
extends Area2D


@export var hurtbox_stats: HurtboxStats
@export var collision_shape: Shape2D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var disabled = false : set = set_disabled
var hits : Array[Hit] = []
var hp: float


func _ready():
	hp = hurtbox_stats.max_hp
	$CollisionShape2D.shape = collision_shape


func set_disabled(value: bool):
	disabled = value
	$CollisionShape2D.set_deferred("disabled", value)
	if not disabled and not hits.is_empty():
		on_hit(hits.front())


func add_hit(hit : Hit):
	hits.append(hit)
	if not hits.is_empty():
		on_hit(hits.front())


func remove_hit(dealer : Node2D):
	var index = 0
	for hit in hits:
		if hit.hash() == hash(dealer):
			break
		index += 1
	if index < hits.size():
		hits.remove_at(index)


func on_hit(hit: Hit):
	if not disabled:
		hp -= hit.damage
	if hp <= 0.0:
		_on_death()
	
	#TODO controlar tempo de imunidade via animações
	set_disabled(true)
	await get_tree().create_timer(hurtbox_stats.inmunity_frames * get_process_delta_time()).timeout
	set_disabled(false)


func heal(heal_amount : float):
	on_heal(heal_amount)


func on_heal(heal_amount : float):
	hp = min(hp + heal_amount, hurtbox_stats.max_hp)
	
	#TODO controlar tempo de imunidade via animações
	set_disabled(true)
	await get_tree().create_timer(hurtbox_stats.inmunity_frames * get_process_delta_time()).timeout
	set_disabled(false)


func _on_death():
	if "death" in animation_player.get_animation_list():
		animation_player.play("death")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Spikes"):
		on_hit(Hit.new(1, body, get_parent()))
