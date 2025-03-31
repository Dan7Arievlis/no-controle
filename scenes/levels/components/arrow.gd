extends Sprite2D

var time : float
var render_offset : float

@export var amp : float
@export var freq : float

func _ready() -> void:
	render_offset = position.y


func _process(delta: float) -> void:
	time += delta
	position = Vector2(0, get_sine())


func get_sine():
	return sin(time * amp) * freq + render_offset
