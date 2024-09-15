extends Sprite2D

var time : float
var render_offset : int

func _ready() -> void:
	render_offset = position.y


func _process(delta: float) -> void:
	time += delta
	position = Vector2(0, get_sine())


func get_sine():
	return sin(time * 6) * 1.5 + render_offset
