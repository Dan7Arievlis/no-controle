extends CenterContainer

@onready var settings_menu: VBoxContainer = $SettingsMenu
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var resolution_button: MenuButton = $SettingsMenu/HBoxContainer/ResolutionButton

func _ready() -> void:
	set_resolution(Vector2(1920, 1080))


func initialize(min_size : Vector2):
	custom_minimum_size = min_size


func _on_resume_button_pressed() -> void:
	get_tree().get_first_node_in_group("Pause Menu").toggle_pause()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_settings_pressed():
	v_box_container.visible = false
	settings_menu.visible = true


func _on_back_button_pressed():
	v_box_container.visible = true
	settings_menu.visible = false


func _on_quit_button_pressed():
	get_tree().quit()


func resolution_button_selected(id: int):
	var resolutions = [Vector2(1920, 1080), Vector2(1080, 720)]
	set_resolution(resolutions[id])


func set_resolution(resolution: Vector2):
	get_viewport().size = resolution
	resolution_button.text = str(resolution.x) + "x" + str(resolution.y)
