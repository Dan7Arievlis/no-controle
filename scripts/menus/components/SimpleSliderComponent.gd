extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var value_label: Label = $HBoxContainer/ValueLabel


var change_stats : Resource
var change_variable : String


func initialiaze(label_name : String, min_value : float, max_value : float, \
		step : float, stats : Resource, variable : String, tooltip : String = ""):
	label.text = label_name + ":"
	add_tooltip(tooltip)
	h_slider.min_value = min_value
	h_slider.max_value = max_value
	h_slider.step = step
	
	change_stats = stats
	change_variable = variable
	
	value_label.text = "%.02f" % stats.get(variable)
	h_slider.value = stats.get(variable)


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
	label.tooltip_text = result


func _on_slider_value_changed(value: float) -> void:
	if change_stats:
		change_stats.set(change_variable, value)
	value_label.text = "%.02f" % value
