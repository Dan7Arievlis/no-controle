class_name EffectAnimation
extends Node2D

@export var effect : EffectResource

@onready var root = get_tree().get_root()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var flip_h : bool
var flip_v : bool
var _effect_name : String


func spawn_effect(_effect : EffectResource, pos : Vector2, root : Node, effect_material : Material, effect_rotation : float, _flip_h : bool = false, _flip_v : bool = false):
	effect = _effect
	global_position = pos
	flip_h = _flip_h
	flip_v = _flip_v
	material = effect_material
	global_rotation = effect_rotation
	root.add_child(self)
	play()


func set_effect(_effect : EffectResource):
	effect = _effect


func _ready() -> void:
	if flip_h: scale.x = -1
	if flip_v: scale.y = -1
	_effect_name = "effects/" + effect.animation.resource_name

func play():
	if animation_player:
		if _effect_name in animation_player.get_animation_list():
			animation_player.stop()
			animation_player.play(_effect_name)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
