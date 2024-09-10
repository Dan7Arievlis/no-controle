class_name HurtboxStats
extends Resource

@export var max_hp: float
@export var inmunity_frames: int


func _init(_max_hp : float = 0, _inmunity_frames : int = 0) -> void:
	max_hp = _max_hp
	inmunity_frames = _inmunity_frames
