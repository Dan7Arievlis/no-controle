class_name MovingPlatform
extends Path2D

@export var loop : bool = false
var direction : int = 1


@onready var path: PathFollow2D = $PathFollow2D


func _physics_process(delta: float) -> void:
	path.progress += direction
	path.loop = loop
	if not loop:
		if path.progress_ratio >= 1 or path.progress_ratio <= 0:
			direction = -direction
