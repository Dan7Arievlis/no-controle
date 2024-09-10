extends ScrollContainer

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer

func add_element(element : Control):
	v_box_container.add_child(element)


func initialize(min_size : Vector2):
	custom_minimum_size = min_size
