extends Control

@export var section_enabler : SectionEnabler
@export var colors : Array[Color]
@export var sections : Array[SectionResource]

@onready var section_box: HBoxContainer = %SectionBox

const SECTION_SELECTION_BUTTON = preload("res://scenes/menus/components/section_selection_button.tscn")

func _ready() -> void:
	var offset = [658, 18, 338, 978, 1298]
	for i in range(offset.size()):
		var section = SECTION_SELECTION_BUTTON.instantiate()
		section_box.add_child(section)
		section.section_resource = sections[i]
		if i < offset.size() - 1: 
			if _unlock_next_section(section):
				section_enabler.add_sections_enabled(i + 1)
		section.available = bool(section_enabler.has_flag(i))
		section.initialize(offset[i], colors[i])


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _unlock_next_section(section):
	var res = true
	for level in section.section_resource.levels:
		res = res and FileAccess.file_exists(format_user_path(level.resource_path))
	
	return res


func format_user_path(resorce_path : String):
	var result : String = resorce_path.erase(0, 6)
	var splited = result.split("/")
	if splited.size() == 5:
		result = "user://%s/%s/%s" % [splited[1], splited[2], splited[4]]
	return result
