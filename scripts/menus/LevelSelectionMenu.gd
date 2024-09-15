extends PanelContainer

const LEVEL_BUTTON = preload("res://scenes/menus/components/level_button.tscn")

@onready var title: Label = %Title
@onready var check: CanvasLayer = %Check
@onready var description: RichTextLabel = %RichTextLabel
@onready var level_list: VBoxContainer = %VBoxContainer
@export var section_resource : SectionResource

func _ready() -> void:
	section_resource = SavedResources.current_section
	#section_resource = load("res://resources/levels/current_section.tres")
	title.text = section_resource.section_title
	
	for level in section_resource.levels:
		_add_level(level)
	
	for level_btn in level_list.get_children():
		level_btn.connect("display_check", _on_display_check)
		level_btn.connect("display_message", _on_description_change)


func _add_level(level : LevelResource):
	var level_btn = LEVEL_BUTTON.instantiate()
	var user_path = "user%s" % level.resource_path.erase(0, 3)
	if not FileAccess.open(user_path, FileAccess.READ):
		level_btn.level_resource = load(level.resource_path)
		print("in LevelSelectionMenu.gd: ", level.resource_path)
	else:
		level_btn.level_resource = load(user_path)
		print("in LevelSelectionMenu.gd: ", user_path)
	level_list.add_child(level_btn)


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
