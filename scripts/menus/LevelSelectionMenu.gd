extends PanelContainer

const LEVEL_BUTTON = preload("res://scenes/menus/components/level_button.tscn")

@onready var title: Label = %Title
@onready var check: CanvasLayer = %Check
@onready var description: RichTextLabel = %RichTextLabel
@onready var level_list: VBoxContainer = %VBoxContainer
@export var section_resource : SectionResource

func _ready() -> void:
	section_resource = SavedResources.current_section
	title.text = section_resource.section_title
	
	for level in section_resource.levels:
		_add_level(level)
	
	for level_btn in level_list.get_children():
		level_btn.connect("display_check", _on_display_check)
		level_btn.connect("display_message", _on_description_change)


func _add_level(level : LevelResource):
	var level_btn = LEVEL_BUTTON.instantiate()
	var user_path = format_user_path(level.resource_path)
	if not FileAccess.file_exists(user_path):
		level_btn.level_resource = ResourceLoader.load(level.resource_path)
	else:
		level_btn.level_resource = ResourceLoader.load(user_path)
	level_list.add_child(level_btn)


func format_user_path(resorce_path : String):
	var result : String = resorce_path.erase(0, 6)
	var splited = result.split("/")
	if splited.size() < 5:
		return ""
	result = "user://%s/%s/%s" % [splited[1], splited[2], splited[4]]
	return result


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/section_selection_menu.tscn")


func _on_display_check(value : bool):
	check.visible = value


func _on_description_change(message : String):
	for tween in get_tree().get_processed_tweens():
		tween.stop()
	description.clear()
	description.visible_ratio = 0
	description.text = message
	var tween_time = message.length() * 0.03
	create_tween().tween_property(description, "visible_ratio", 1, tween_time)
