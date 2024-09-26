extends MenuComponentCreator


func draw_menu(stats : PlayerStats):
	var selection_tab = TAB_COMPONENT.instantiate()
	create_tab(selection_tab)
	
#region Movement Page
	var movement_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, movement_page, "Movimento", LARGE_PAGE)
	
	create_toggle_button("Habilitar movimento", stats.MOVEMENT_STATS, "enable_movement", movement_page)
	
	var movement_set_tab = TAB_COMPONENT.instantiate()
	create_tab(movement_set_tab, movement_page)
	
#region Speed Page
	var speed_page = PAGE_COMPONENT.instantiate()
	create_page(movement_set_tab, speed_page, "Velocidade", MEDIUM_PAGE)
	
	create_simple_slider("Velocidade de caminhada", 30, 300, 0.1, stats.MOVEMENT_STATS, "walk_speed", speed_page,
		"Velocidade máxima que pode se alcançar ao caminhar.")
	create_simple_slider("Velocidade de virada", 0, 10, 0.1, stats.MOVEMENT_STATS, "turn_speed", speed_page,
		"Influencia no tempo para que a direção de movimento se iguale à direção do input enquanto no chão.")
	create_simple_slider("Velocidade de virada no ar", 0, 10, 0.1, stats.MOVEMENT_STATS, "air_turn_speed", speed_page, 
		"Influencia no controle de movimento aéreo. Valores baixos fixam a tajetória no ar em relação à direção do primeiro momento no ar.")
	create_trigger("can_run", create_toggle_button("Pode correr", stats.MOVEMENT_STATS, "can_run", speed_page))
	create_observer("can_run", create_simple_slider("Velocidade de corrida", 200, 450, 0.1, stats.MOVEMENT_STATS, "run_speed", speed_page))
#endregion
	
#region Acceleration page
	var acceleration_page = PAGE_COMPONENT.instantiate()
	create_page(movement_set_tab, acceleration_page, "Aceleração", MEDIUM_PAGE)
	
	create_simple_slider("Taxa de aceleração", 0, 12, 0.1, stats.MOVEMENT_STATS, "accel_rate", acceleration_page,
		"Influencia o tempo para alcançar a velocidade máxima enquanto estiver no chão.")
	create_simple_slider("Taxa de desaceleração", 0, 12, 0.1, stats.MOVEMENT_STATS, "decel_rate", acceleration_page,
		"Influencia o tempo para se manter estacionário enquanto estiver no chão.")
	create_simple_slider("Taxa de aceleração no ar", 0, 12, 0.1, stats.MOVEMENT_STATS, "air_accel_rate", acceleration_page,
		"Influencia o tempo para alcançar a velocidade máxima enquanto estiver no ar.")
	create_simple_slider("Taxa de desaceleração no ar", 0, 12, 0.1, stats.MOVEMENT_STATS, "air_decel_rate", acceleration_page,
		"Influencia o tempo para se manter estacionário enquanto estiver no ar.")
#endregion
#endregion
	
#region Jump Page
	var jump_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, jump_page, "Pulo", LARGE_PAGE)
	
	create_toggle_button("Habilitar pulo", stats.JUMP_STATS, "enable_jump", jump_page)
	
	var jump_set_tab = TAB_COMPONENT.instantiate()
	create_tab(jump_set_tab, jump_page)
	
#region Impulses
	var impulses_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, impulses_page, "Impulsos", MEDIUM_PAGE)
	
	create_simple_slider("Velocidade do pulo", 10, 600, 1, stats.JUMP_STATS, "jump_velocity", impulses_page,
		"Influencia na altura máxima que um pulo poderá alcançar")
	create_label("Tempo de Coiote e Buffer de Pulo", impulses_page)
	create_simple_slider("Tempo de Coiote", 0.016, 0.3, 0.016, stats.JUMP_STATS, "coyote_time", impulses_page,
		"Determina o tempo, em segundos, que a ação de pulo pode ser identificada como input mesmo após o personagem deixar o chão.")
	create_simple_slider("Buffer de tempo", 0.016, 0.3, 0.016, stats.JUMP_STATS, "jump_buffer", impulses_page,
		"Determina o tempo, em segundos, que a ação de pulo pode ser identificada como input quando executada logo antes de alcançar o chão novamente.")
	create_label("Pulo duplo", impulses_page)
	create_trigger("double_jump", create_toggle_button("Pode dar pulo duplo", stats.JUMP_STATS, "double_jump", impulses_page))
	create_observer("double_jump", create_simple_slider("Velocidade de pulo duplo", 10, 500, 2, stats.JUMP_STATS, "double_jump_velocity", impulses_page,
		"Influencia na altura máxima que um segundo pulo executado no ar poderá alcançar."))
	create_observer("double_jump", create_simple_slider("Espera para pulo", 0, 0.2, 0.016, stats.JUMP_STATS, "jump_wait", impulses_page,
		"Tempo de delay para efetivação do segundo pulo."))
#endregion
	
#region Falling
	var falling_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, falling_page, "Queda", MEDIUM_PAGE)
	
	create_simple_slider("Velocidade máxima de queda", 10, 900, 1, stats.JUMP_STATS, "max_fall_speed", falling_page)
	create_label("Modificadores de gravidade", falling_page)
	create_simple_slider("Multiplicador de gravidade na queda", 1, 5, 0.1, stats.JUMP_STATS, "gravity_fall_multiplier", falling_page,
		"Altera o comportamento da gravidade em um personagem em queda, recomendado para que não passe a sensação que está flutuando.")
	create_simple_slider("Multiplicador para corte do pulo", 0, 1, 0.01, stats.JUMP_STATS, "jump_cut_multiplier", falling_page,
		"Afeta a altura do pulo ao soltar o botão de pulo durante a subida. Quando o multiplicador está em 0, a velocidade do pulo é cortada imediatamente e o personagem começa a cair no mesmo instante; quando o multiplicador é 1, o pulo permanece inalterado mesmo se o botão for liberado.")
#endregion
	
#region Apex
	var apex_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, apex_page, "Ápice", MEDIUM_PAGE)
	
	create_simple_slider("Multiplicador de gravidade no ápice", 1, 5, 0.01, stats.JUMP_STATS, "gravity_apex_multiplier", apex_page,
		"Diminui a velocidade de queda do personagem enquando estiver no ápice do pulo.")
	create_simple_slider("Multiplicador de velocidade no ápice", 1, 5, 0.01, stats.JUMP_STATS, "apex_speed_multiplier", apex_page,
		"Aumenta a velocidade horizontal do personagem enquanto estiver no ápice do pulo.")
	create_simple_slider("Margem de ápice", 0, 80, 1, stats.JUMP_STATS, "apex_margin", apex_page,
		"Define a duração do ápice do pulo do personagem.")
#endregion
#endregion
	
	var settings = SETTINGS_SCENE.instantiate()
	create_page(selection_tab, settings, "Configurações", LARGE_PAGE)
