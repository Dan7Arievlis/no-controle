extends Control

@onready var label: Label = $Label
@onready var check_button: CheckButton = $CheckButton
@onready var question_button: Button = %QuestionButton

var change_stats : Resource
var change_variable : String
var elements_linked = []


func initialiaze(label_name : String, stats : Resource, variable : String, tooltip : String = ""):
	label.text = label_name + ":"
	add_tooltip(tooltip)
	change_stats = stats
	change_variable = variable
	
	check_button.button_pressed = stats.get(variable)


func add_tooltip(tooltip):
	var max_length = 32
	var i : int = 0
	var result = ""
	for ch in tooltip:
		i += 1
		result += ch
		if i >= max_length and ch == ' ':
			result += '\n'
			i = 0
	question_button.tooltip_text = result
	question_button.visible = not result.is_empty()


func connect_element(element : CanvasItem):
	elements_linked.append(element)
	element.visible = change_stats.get(change_variable)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if change_stats:
		change_stats.set(change_variable, toggled_on)
	for element in elements_linked:
		element.visible = toggled_on
