extends CanvasLayer

var current_level_path : String
var current_level : LevelResource

func _ready() -> void:
	var exit = get_tree().get_first_node_in_group("Exit")
	if exit:
		exit.connect("exit_level", exit_level.bind())
	#current_level = load(current_level_path)
	current_level = SavedResources.current_level
	current_level_path = "user%s" % current_level.resource_path.erase(0, 3)
	print("in WinMenu.gd: loaded: %s" % current_level_path)
	hide()


func exit_level():
	current_level.done = true
	if not FileAccess.file_exists(current_level_path):
		var file = FileAccess.open(current_level_path, FileAccess.READ_WRITE)
		print("in WinMenu.gd: file created: %s (%s)" % [current_level_path, file])
	var error = ResourceSaver.save(SavedResources.current_level, current_level_path)
	if error != OK:
		print("in WinMenu.gd: failed save: ", current_level_path)
	else:
		print("in WinMenu.gd: successful save: ", current_level_path)
	show()


func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()


func _on_level_selection_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/section_selection_menu.tscn")


func _on_desktop_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	if get_tree():
		get_tree().paused = visible
	$Panel/CanvasLayer.visible = visible
	$Panel/CanvasLayer2.visible = visible
	$Panel/CanvasLayer3.visible = visible
