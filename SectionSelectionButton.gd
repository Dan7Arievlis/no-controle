extends Control

@export var section_resource : SectionResource
@export var available : bool :
	set(value):
		button.disabled = not value
	
		button.modulate =  Color("a2a2a2") if button.disabled else Color("ffffff")
		overlay.modulate = Color("a2a2a2") if button.disabled else Color("ffffff")
		overlay.z_index = 0 - int(button.disabled)
		locker.z_index = 0 - int(button.disabled)
		locker.visible = button.disabled
	
@onready var button: TextureButton = $Button
@onready var overlay: TextureRect = $Panel/Overlay
@onready var locker: TextureRect = $Panel/Locker

var game_color : Color

const COLOR_CHANGE_FILTER = preload("res://materials/color_change_filter.tres")
const COLOR_CHANGE_MATERIAL = preload("res://materials/color_change_material.tres")

func initialize(rect : Rect2, color : Color) -> void:
	overlay.texture.region = rect
	button.texture_normal.region = rect
	
	game_color = color


func _on_texture_button_pressed() -> void:
	if not button.disabled:
		COLOR_CHANGE_FILTER.set_shader_parameter("overlay", game_color)
		COLOR_CHANGE_MATERIAL.set_shader_parameter("color", game_color)
		ResourceSaver.save(section_resource, "res://scripts/resources/current_section.tres")
		get_tree().change_scene_to_file("res://scenes/level_selection_menu.tscn")


func _on_button_mouse_entered() -> void:
	if not button.disabled:
		COLOR_CHANGE_FILTER.set_shader_parameter("overlay", game_color)
		COLOR_CHANGE_MATERIAL.set_shader_parameter("color", game_color)
