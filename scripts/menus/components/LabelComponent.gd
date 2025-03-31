extends MarginContainer

@onready var label: Label = $HBoxContainer/Label
@onready var question_button: Button = %QuestionButton

func initialize(text : String, tooltip : String = ""):
	label.text = text
	add_tooltip(tooltip)


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
