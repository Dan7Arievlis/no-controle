# MenuComponentCreator
class_name MenuComponentCreator
extends VBoxContainer

const CHECK_BUTTON_CONTROL = preload("res://scenes/menus/components/check_button_control.tscn")
const COMPOUND_SLIDER_CONTROL = preload("res://scenes/menus/components/compound_slider_control.tscn")
const PAGE_COMPONENT = preload("res://scenes/menus/components/page_component.tscn")
const SIMPLE_SLIDER_CONTROL = preload("res://scenes/menus/components/simple_slider_control.tscn")
const TAB_COMPONENT = preload("res://scenes/menus/components/tab_component.tscn")
const LABEL_COMPONENT = preload("res://scenes/menus/components/label_component.tscn")
const SETTINGS_SCENE = preload("res://scenes/menus/components/settings_scene.tscn")

const LARGE_PAGE : Vector2 = Vector2(700, 630)
const MEDIUM_PAGE_PLUS : Vector2 = Vector2(690, 550)
const MEDIUM_PAGE : Vector2 = Vector2(690, 470)
const SMALL_PAGE : Vector2 = Vector2(655, 350)

var triggers = {}

func draw_menu(_stats : PlayerStats):
	pass


func create_trigger(trigger_key : String, button : Control):
	triggers.get_or_add(trigger_key, button)


func create_observer(trigger_key : String, element : Control):
	var trigger = triggers.get(trigger_key)
	if trigger:
		trigger.connect_element(element)


func create_tab(tab, parent = null):
	if not parent:
		add_child(tab)
	else:
		parent.add_element(tab)
	
	return tab


func create_label(text : String, parent = null, tooltip : String = ""):
	var label = LABEL_COMPONENT.instantiate()
	if not parent:
		add_child(label)
	else:
		parent.add_element(label)
	label.initialize(text, tooltip)
	
	return label


func create_page(tab, page, _name, min_size):
	page.name = _name
	tab.add_page(page)
	page.initialize(min_size)
	
	return page


func create_simple_slider(label_name : String, min_value : float, max_value : float, \
		step : float, stats : Resource, variable : String, page : ScrollContainer = null, tooltip : String = ""):
	var slider = SIMPLE_SLIDER_CONTROL.instantiate()
	if page:
		page.add_element(slider)
	else:
		add_child(slider)
	slider.initialiaze(label_name, min_value, max_value, step, stats, variable, tooltip)
	
	return slider


func create_compound_slider(label_name : String, min_value_x : float, max_value_x : float, \
		min_value_y : float, max_value_y : float, step : float, stats : Resource, variable : String, \
		page : ScrollContainer = null, tooltip : String = ""):
	var slider = COMPOUND_SLIDER_CONTROL.instantiate()
	if page:
		page.add_element(slider)
	else:
		add_child(slider)
	slider.initialiaze(label_name, min_value_x, max_value_x, min_value_y, max_value_y, step, stats, variable, tooltip)
	
	return slider


func create_toggle_button(label_name : String, stats : Resource, variable : String, page : ScrollContainer = null,\
		tooltip : String = ""):
	var button = CHECK_BUTTON_CONTROL.instantiate()
	if page:
		page.add_element(button)
	else:
		add_child(button)
	button.initialiaze(label_name, stats, variable, tooltip)
	
	return button
