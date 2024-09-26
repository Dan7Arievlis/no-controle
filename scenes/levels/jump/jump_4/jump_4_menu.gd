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
	
	create_simple_slider("Velocidade do pulo", 200, 550, 1, stats.JUMP_STATS, "jump_velocity", impulses_page,
		"Influencia na altura máxima que um pulo poderá alcançar")
#endregion

#region Falling
	var falling_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, falling_page, "Queda", MEDIUM_PAGE)
	
	create_label("Velocidade máxima de queda: %.02f" % stats.JUMP_STATS.max_fall_speed, falling_page)
	create_label("Modificadores de gravidade", falling_page)
	create_label("Multiplicador para corte do pulo: %.02f" % stats.JUMP_STATS.jump_cut_multiplier, falling_page,
		"Afeta a altura do pulo ao soltar o botão de pulo durante a subida. Quando o multiplicador está em 0, a velocidade do pulo é cortada imediatamente e o personagem começa a cair no mesmo instante; quando o multiplicador é 1, o pulo permanece inalterado mesmo se o botão for liberado.")
#endregion

#region Apex
	var apex_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, apex_page, "Ápice", MEDIUM_PAGE)
	
	create_simple_slider("Multiplicador de gravidade no ápice", 1, 12, 0.01, stats.JUMP_STATS, "gravity_apex_multiplier", apex_page,
		"Diminui a velocidade de queda do personagem enquando estiver no ápice do pulo.")
	create_simple_slider("Multiplicador de velocidade no ápice", 1, 12, 0.01, stats.JUMP_STATS, "apex_speed_multiplier", apex_page,
		"Aumenta a velocidade horizontal do personagem enquanto estiver no ápice do pulo.")
	create_simple_slider("Margem de ápice", 0, 50, 1, stats.JUMP_STATS, "apex_margin", apex_page,
		"Define a duração do ápice do pulo do personagem.")
#endregion
#endregion
	
	var settings = SETTINGS_SCENE.instantiate()
	create_page(selection_tab, settings, "Configurações", LARGE_PAGE)
