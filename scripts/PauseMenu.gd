extends CanvasLayer

@onready var component_creator : MenuComponentCreator = $Panel/PanelContainer/VBoxContainer

func _ready() -> void:
	hide()


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()


func _on_resume_button_pressed():
	toggle_pause()


func toggle_pause():
	visible = not visible
	get_tree().paused = not get_tree().paused
	#_on_back_button_pressed()
