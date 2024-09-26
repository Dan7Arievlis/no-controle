extends CanvasLayer

@onready var credits: PanelContainer = $Container/PanelContainer
@onready var setting_panel: PanelContainer = $Container/SettingPanel
@onready var popup: PanelContainer = $Container/Popup

const COLOR_CHANGE_FILTER = preload("res://materials/color_change_filter.tres")
const COLOR_CHANGE_MATERIAL = preload("res://materials/color_change_material.tres")

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_tree().call_group("Projectile", "queue_free")


func _on_choose_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/section_selection_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	credits.visible = not credits.visible


func _on_settings_pressed() -> void:
	setting_panel.visible = not setting_panel.visible


func _on_delete_pressed() -> void:
	popup.visible = not popup.visible
	setting_panel.visible = false


func _on_confirm_pressed() -> void:
	if DirAccess.dir_exists_absolute("user://levels"):
		OS.move_to_trash(ProjectSettings.globalize_path("user://levels"))
	popup.visible = false
	setting_panel.visible = false
	
