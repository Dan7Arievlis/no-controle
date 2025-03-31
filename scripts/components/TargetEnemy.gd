extends Path2D

@export var loop : bool = false
@export_range(0.0, 1.0) var progress : float = 0.0
var direction : int = 1


@onready var path: PathFollow2D = $PathFollow2D

func _ready() -> void:
	path.progress_ratio = progress


func _physics_process(_delta: float) -> void:
	path.progress += direction
	path.loop = loop
	if not loop:
		if path.progress_ratio >= 1 or path.progress_ratio <= 0:
			direction = -direction
