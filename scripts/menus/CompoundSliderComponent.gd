extends Control

@onready var label: Label = $VBoxContainer/HBoxContainer/Label
@onready var x_slider: HSlider = $VBoxContainer/HBoxContainer/XSlider
@onready var value_label_x: Label = $VBoxContainer/HBoxContainer/ValueLabelX
@onready var y_slider: HSlider = $VBoxContainer/HBoxContainer2/YSlider
@onready var value_label_y: Label = $VBoxContainer/HBoxContainer2/ValueLabelY

var change_stats : Resource
var change_variable : String


func initialiaze(label_name : String, min_value_x : float, max_value_x : float, \
		min_value_y : float, max_value_y : float, step : float, stats : Resource, variable : String, \
		tooltip : String = ""):
	label.text = label_name + ":"
	add_tooltip(tooltip)
	x_slider.min_value = min_value_x
	x_slider.max_value = max_value_x
	x_slider.step = step
	
	y_slider.min_value = min_value_y
	y_slider.max_value = max_value_y
	y_slider.step = step
	
	change_stats = stats
	change_variable = variable
	
	value_label_x.text = "%.02f" % stats.get(variable)[0]
	x_slider.value = stats.get(variable)[0]
	
	value_label_y.text = "%.02f" % stats.get(variable)[1]
	y_slider.value = stats.get(variable)[1]


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


func _on_x_slider_value_changed(value: float) -> void:
	if change_stats:
		change_stats.set(change_variable, Vector2(value, change_stats.get(change_variable)[1]))
	value_label_x.text = "%.02f" % value


func _on_y_slider_value_changed(value: float) -> void:
	if change_stats:
		change_stats.set(change_variable, Vector2(change_stats.get(change_variable)[0], value))
	value_label_y.text = "%.02f" % value
