extends Control

@export var section_enabler : SectionEnabler
@export var colors : Array[Color]
@export var sections : Array[SectionResource]

@onready var section_box: HBoxContainer = $VBoxContainer/CanvasLayer2/HBoxContainer

const SECTION_SELECTION_BUTTON = preload("res://scenes/section_selection_button.tscn")

#FIXME consertar as imagens repetidas nos botões
func _ready() -> void:
	var offset = [18, 338, 658, 978, 1298]
	for i in range(offset.size()):
		#var rect = Rect2(1298 + 658 - (1298 - 658 + offset), 18, 284, 684)
		var rect = Rect2(offset[i], 18, 284, 684)
		var section = SECTION_SELECTION_BUTTON.instantiate()
		section_box.add_child(section)
		section.section_resource = sections[i]
		if i < offset.size() - 1: 
			if _unlock_next_section(section):
				section_enabler.add_sections_enabled(i + 1)
		section.available = bool(section_enabler.has_flag(i))
		section.initialize(rect, colors[i])


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _unlock_next_section(section):
	var res = true
	for level in section.section_resource.levels:
		res = res and level.done
	
	return res
