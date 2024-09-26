extends MenuComponentCreator


func draw_menu(stats : PlayerStats):
	var selection_tab = TAB_COMPONENT.instantiate()
	var movement_page = PAGE_COMPONENT.instantiate()
	create_tab(selection_tab)
	
#region Movement Page
	create_page(selection_tab, movement_page, "Movimento", LARGE_PAGE)
	
	create_toggle_button("Habilitar movimento", stats.MOVEMENT_STATS, "enable_movement", movement_page)
	
	var movement_set_tab = TAB_COMPONENT.instantiate()
	create_tab(movement_set_tab, movement_page)
	
#region Speed Page
	var speed_page = PAGE_COMPONENT.instantiate()
	create_page(movement_set_tab, speed_page, "Velocidade", MEDIUM_PAGE)
	
	create_label("Velocidade de caminhada: %.02f" % stats.MOVEMENT_STATS.walk_speed, speed_page,
		"Velocidade máxima que pode se alcançar ao caminhar.")
	create_simple_slider("Velocidade de virada", 0, 1.5, 0.01, stats.MOVEMENT_STATS, "turn_speed", speed_page,
		"Influencia no tempo para que a direção de movimento se iguale à direção do input enquanto no chão.")
#endregion
#endregion
	
#region Jump Page
	var jump_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, jump_page, "Pulo", LARGE_PAGE)
	
	create_label("Pulo desabilitado", jump_page)
#endregion
	
	var settings = SETTINGS_SCENE.instantiate()
	create_page(selection_tab, settings, "Configurações", LARGE_PAGE)
