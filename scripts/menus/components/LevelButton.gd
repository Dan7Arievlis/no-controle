extends MarginContainer

signal display_message(message)
signal display_check(value)

@onready var button: Button = $Button

var level_resource : LevelResource

func _ready() -> void:
	button.text = level_resource.title


func _on_button_mouse_entered() -> void:
	display_message.emit("")
	display_message.emit(level_resource.description)
	display_check.emit(level_resource.done)


func _on_button_mouse_exited() -> void:
	pass


func _on_button_pressed() -> void:
	SavedResources.current_level = level_resource
	SavedResources.current_stats = level_resource.stats.duplicate(true)
	get_tree().change_scene_to_packed(level_resource.level_scene)
