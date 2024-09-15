extends CanvasLayer

@onready var credits: PanelContainer = $Container/PanelContainer

const COLOR_CHANGE_FILTER = preload("res://materials/color_change_filter.tres")
const COLOR_CHANGE_MATERIAL = preload("res://materials/color_change_material.tres")

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_choose_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/section_selection_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	credits.visible = not credits.visible
