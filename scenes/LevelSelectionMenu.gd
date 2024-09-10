extends PanelContainer

const LEVEL_BUTTON = preload("res://level_button.tscn")

@onready var title: Label = $MarginContainer/VBoxContainer/Title
@onready var check: CanvasLayer = $MarginContainer/VBoxContainer/Check
@onready var description: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer2/ScrollContainer/PanelContainer/RichTextLabel
@onready var level_list: VBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/ScrollContainer/PanelContainer/VBoxContainer
@export var section_resource : SectionResource

func _ready() -> void:
	section_resource = load("res://scripts/resources/current_section.tres")
	title.text = section_resource.section_title
	
	for level in section_resource.levels:
		_add_level(level)
	
	for level_btn in level_list.get_children():
		level_btn.connect("display_check", _on_display_check)
		level_btn.connect("display_message", _on_description_change)


func _add_level(level : LevelResource):
	var level_btn = LEVEL_BUTTON.instantiate()
	level_btn.level_resource = level
	level_list.add_child(level_btn)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/section_selection_menu.tscn")


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
