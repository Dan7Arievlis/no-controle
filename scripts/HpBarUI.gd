extends TextureProgressBar


func _ready() -> void:
	var player = get_tree().get_first_node_in_group("Player")
	player.connect("max_life_changed", _set_max_value.bind())
	player.connect("life_changed", set_progress_value.bind())


func _set_max_value(_value : float):
	set_progress_value(_value)
	max_value = _value


func set_progress_value(_value : float):
	value = _value
