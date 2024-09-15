extends CanvasLayer

signal respawn_signal()
var player : Player

func _ready() -> void:
	player = get_parent().get_node("Player")
	hide()


func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_desktop_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	$Panel/CanvasLayer.visible = visible
	$Panel/CanvasLayer2.visible = visible
	$Panel/CanvasLayer3.visible = visible
