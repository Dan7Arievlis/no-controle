extends TileMapLayer

const ONE_WAY_PLATFORM := preload("res://scenes/components/one_way_platform.tscn")


func _ready() -> void:
	for cellpos in get_used_cells():
		var object = ONE_WAY_PLATFORM.instantiate()
		object.position = map_to_local(cellpos) * scale
		add_child(object)
		
