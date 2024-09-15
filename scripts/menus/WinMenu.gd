extends CanvasLayer

var current_level_path : String
var current_level : LevelResource

func _ready() -> void:
	var exit = get_tree().get_first_node_in_group("Exit")
	if exit:
		exit.connect("exit_level", exit_level.bind())
	current_level = SavedResources.current_level
	if current_level.resource_path.begins_with("res://"):
		current_level_path = format_user_path(current_level.resource_path)
	else:
		current_level_path = current_level.resource_path
	hide()


func exit_level():
	current_level.done = true
	save_progress()
	show()


func save_progress():
	if not FileAccess.file_exists(current_level_path):
		var dir_path = "user://levels/%s" % get_section()
		if not DirAccess.dir_exists_absolute(dir_path):
			DirAccess.make_dir_recursive_absolute(dir_path)
		var file = FileAccess.open(current_level_path, FileAccess.READ_WRITE)
	var error = ResourceSaver.save(SavedResources.current_level, current_level_path)


func format_user_path(resorce_path : String):
	var result : String = resorce_path.erase(0, 6)
	var splited = result.split("/")
	result = "user://%s/%s/%s" % [splited[1], splited[2], splited[4]]
	return result


func get_section():
	var path : String = current_level_path.erase(0, 6)
	var splited = path.split("/")
	return splited[2]


func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()


func _on_level_selection_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/level_selection_menu.tscn")


func _on_desktop_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	if get_tree():
		get_tree().paused = visible
	$Panel/CanvasLayer.visible = visible
	$Panel/CanvasLayer2.visible = visible
	$Panel/CanvasLayer3.visible = visible
