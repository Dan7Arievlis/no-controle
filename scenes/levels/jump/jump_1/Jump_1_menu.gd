extends MenuComponentCreator


func draw_menu(stats : PlayerStats):
	var selection_tab = TAB_COMPONENT.instantiate()
	create_tab(selection_tab)
	
#region Jump Page
	var jump_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, jump_page, "Pulo", LARGE_PAGE)
	
	create_toggle_button("Habilitar pulo", stats.JUMP_STATS, "enable_jump", jump_page)
	
	var jump_set_tab = TAB_COMPONENT.instantiate()
	create_tab(jump_set_tab, jump_page)
	
#region Impulses
	var impulses_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, impulses_page, "Impulsos", MEDIUM_PAGE)
	
	create_simple_slider("Velocidade do pulo", 10, 900, 1, stats.JUMP_STATS, "jump_velocity", impulses_page,
		"Influencia na altura máxima que um pulo poderá alcançar")
#endregion
#endregion
	
	var settings = SETTINGS_SCENE.instantiate()
	create_page(selection_tab, settings, "Configurações", LARGE_PAGE)
