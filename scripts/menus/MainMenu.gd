extends CanvasLayer

@onready var credits: PanelContainer = $Panel/Container/PanelContainer

const COLOR_CHANGE_FILTER = preload("res://materials/color_change_filter.tres")
const COLOR_CHANGE_MATERIAL = preload("res://materials/color_change_material.tres")

func _ready() -> void:
	var base_color = Color("001db0")
	COLOR_CHANGE_FILTER.set_shader_parameter("overlay", base_color)
	COLOR_CHANGE_MATERIAL.set_shader_parameter("color", base_color)


func _on_choose_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/section_selection_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	credits.visible = not credits.visible
