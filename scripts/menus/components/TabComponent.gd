extends MarginContainer

@onready var tab_container: TabContainer = $TabContainer

func add_page(page : Container):
	tab_container.add_child(page)
