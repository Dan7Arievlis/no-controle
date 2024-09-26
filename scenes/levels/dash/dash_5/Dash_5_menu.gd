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
	create_simple_slider("Velocidade de virada", 0, 20, 0.1, stats.MOVEMENT_STATS, "turn_speed", speed_page,
		"Influencia no tempo para que a direção de movimento se iguale à direção do input enquanto no chão.")
	create_simple_slider("Velocidade de virada no ar", 0, 20, 0.1, stats.MOVEMENT_STATS, "air_turn_speed", speed_page, 
		"Influencia no controle de movimento aéreo. Valores baixos fixam a tajetória no ar em relação à direção do primeiro momento no ar.")
	create_trigger("can_run", create_toggle_button("Pode correr", stats.MOVEMENT_STATS, "can_run", speed_page))
	create_observer("can_run", create_simple_slider("Velocidade de corrida", 200, 600, 0.1, stats.MOVEMENT_STATS, "run_speed", speed_page))
#endregion
	
#region Acceleration page
	var acceleration_page = PAGE_COMPONENT.instantiate()
	create_page(movement_set_tab, acceleration_page, "Aceleração", MEDIUM_PAGE)
	
	create_simple_slider("Taxa de aceleração", 0, 20, 0.1, stats.MOVEMENT_STATS, "accel_rate", acceleration_page,
		"Influencia o tempo para alcançar a velocidade máxima enquanto estiver no chão.")
	create_simple_slider("Taxa de desaceleração", 0, 20, 0.1, stats.MOVEMENT_STATS, "decel_rate", acceleration_page,
		"Influencia o tempo para se manter estacionário enquanto estiver no chão.")
	create_simple_slider("Taxa de aceleração no ar", 0, 20, 0.1, stats.MOVEMENT_STATS, "air_accel_rate", acceleration_page,
		"Influencia o tempo para alcançar a velocidade máxima enquanto estiver no ar.")
	create_simple_slider("Taxa de desaceleração no ar", 0, 20, 0.1, stats.MOVEMENT_STATS, "air_decel_rate", acceleration_page,
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
	
	create_simple_slider("Velocidade do pulo", 10, 1000, 1, stats.JUMP_STATS, "jump_velocity", impulses_page,
		"Influencia na altura máxima que um pulo poderá alcançar")
	create_label("Tempo de Coiote e Buffer de Pulo", impulses_page)
	create_simple_slider("Tempo de Coiote", 0.016, 0.3, 0.016, stats.JUMP_STATS, "coyote_time", impulses_page,
		"Determina o tempo, em segundos, que a ação de pulo pode ser identificada como input mesmo após o personagem deixar o chão.")
	create_simple_slider("Buffer de tempo", 0.016, 0.3, 0.016, stats.JUMP_STATS, "jump_buffer", impulses_page,
		"Determina o tempo, em segundos, que a ação de pulo pode ser identificada como input quando executada logo antes de alcançar o chão novamente.")
	create_label("Pulo duplo", impulses_page)
	create_trigger("double_jump", create_toggle_button("Pode dar pulo duplo", stats.JUMP_STATS, "double_jump", impulses_page))
	create_observer("double_jump", create_simple_slider("Velocidade de pulo duplo", 10, 800, 2, stats.JUMP_STATS, "double_jump_velocity", impulses_page,
		"Influencia na altura máxima que um segundo pulo executado no ar poderá alcançar."))
	create_observer("double_jump", create_simple_slider("Espera para pulo", 0, 0.2, 0.016, stats.JUMP_STATS, "jump_wait", impulses_page,
		"Tempo de delay para efetivação do segundo pulo."))
#endregion
	
#region Falling
	var falling_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, falling_page, "Queda", MEDIUM_PAGE)
	
	create_simple_slider("Velocidade máxima de queda", 10, 1200, 1, stats.JUMP_STATS, "max_fall_speed", falling_page)
	create_label("Modificadores de gravidade", falling_page)
	create_simple_slider("Multiplicador de gravidade na queda", 1, 5, 0.1, stats.JUMP_STATS, "gravity_fall_multiplier", falling_page,
		"Altera o comportamento da gravidade em um personagem em queda, recomendado para que não passe a sensação que está flutuando.")
	create_simple_slider("Multiplicador para corte do pulo", 0, 1, 0.01, stats.JUMP_STATS, "jump_cut_multiplier", falling_page,
		"Afeta a altura do pulo ao soltar o botão de pulo durante a subida. Quando o multiplicador está em 0, a velocidade do pulo é cortada imediatamente e o personagem começa a cair no mesmo instante; quando o multiplicador é 1, o pulo permanece inalterado mesmo se o botão for liberado.")
#endregion
	
#region Apex
	var apex_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, apex_page, "Ápice", MEDIUM_PAGE)
	
	create_simple_slider("Multiplicador de gravidade no ápice", 1, 3, 0.01, stats.JUMP_STATS, "gravity_apex_multiplier", apex_page,
		"Diminui a velocidade de queda do personagem enquando estiver no ápice do pulo.")
	create_simple_slider("Multiplicador de velocidade no ápice", 1, 3, 0.01, stats.JUMP_STATS, "apex_speed_multiplier", apex_page,
		"Aumenta a velocidade horizontal do personagem enquanto estiver no ápice do pulo.")
	create_simple_slider("Margem de ápice", 0, 100, 1, stats.JUMP_STATS, "apex_margin", apex_page,
		"Define a duração do ápice do pulo do personagem.")
#endregion
#endregion
	
#region Wall Jump Page
	var wall_jumping_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, wall_jumping_page, "Pulo na parede", LARGE_PAGE)
	
	var wall_jumping_tab = TAB_COMPONENT.instantiate()
	create_tab(wall_jumping_tab, wall_jumping_page)
	
#region Wall Slide
	var wall_slide_page = PAGE_COMPONENT.instantiate()
	create_page(wall_jumping_tab, wall_slide_page, "Deslizar na parede", MEDIUM_PAGE_PLUS)
	
	create_toggle_button("Habilitar deslize na parede", stats.WALL_SLIDE_STATS, "enable_wall_slide", wall_slide_page)
	create_observer("double_jump", create_toggle_button("Atualizar pulo duplo", stats.WALL_SLIDE_STATS, "refresh_double_jump", wall_slide_page,
		"Quando habilitado, atualiza o pulo duplo do personagem, possibilitando executar sempre que pular de uma parede."))
	create_simple_slider("Velocidade máxima de deslize", 1, 600, 1, stats.WALL_SLIDE_STATS, "max_wall_slide_velocity", wall_slide_page)
	create_simple_slider("Fricção da parede", 0, 10, 1, stats.WALL_SLIDE_STATS, "wall_friction", wall_slide_page,
		"Influencia no tempo para alcançar a velocidade máxima de deslize na parede")
#endregion
	
#region Wall Jump
	var wall_jump_page = PAGE_COMPONENT.instantiate()
	create_page(wall_jumping_tab, wall_jump_page, "Pulo na parede", MEDIUM_PAGE_PLUS)
	
	create_toggle_button("Habilitar pulo na parede", stats.WALL_JUMP_STATS, "enable_wall_jump", wall_jump_page)
	create_compound_slider("Vetor do pulo", 0, 500, 0, 1000, 1, stats.WALL_JUMP_STATS, "wall_jump_vector", wall_jump_page,
		"Diração e intensidade nas quais o pulo na parede é feito.")
	#create_simple_slider("Tempo de tolerância para pulo", 0, 0.5, 0.01, stats.WALL_JUMP_STATS, "wall_jumping_grace_time", wall_jump_page)
	create_simple_slider("Multiplicador de velocidade de ejeção", 0, 5, 0.1, stats.WALL_JUMP_STATS, "jump_off_wall_multiplier", wall_jump_page,
		"Multiplica a velocidade da coordenada x no vetor de pulo na parede quando o jogador pula na direção oposta da parede.")
#endregion
#endregion
	
#region Dash Page
	var dash_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, dash_page, "Dash", LARGE_PAGE)
	
	create_toggle_button("Habilitar dash",stats. DASH_STATS, "enable_dash", dash_page)
	
	var dash_set_tab = TAB_COMPONENT.instantiate()
	create_tab(dash_set_tab, dash_page)
	
#region Impulse
	var dash_impulse_page = PAGE_COMPONENT.instantiate()
	create_page(dash_set_tab, dash_impulse_page, "Impulso", MEDIUM_PAGE)
	
	create_simple_slider("Força do dash", 10, 1000, 1, stats.DASH_STATS, "dash_force", dash_impulse_page,
		"Influencia a velocidade do dash")
	create_label("Controles direcionais", dash_impulse_page)
	create_toggle_button("Dash com uma direção", stats.DASH_STATS, "one_directional_dash", dash_impulse_page,
		"Quando desabilitado, permite o jogador executar dash em 8 direções diferentes.")
	create_toggle_button("Salvar última horizontal", stats.DASH_STATS, "save_last_horizontal", dash_impulse_page,
		"Quando habilitado, permite executar um dash horizontal mesmo quando o jogador estiver parado.")
#endregion
	
#region Timers
	var dash_timers = PAGE_COMPONENT.instantiate()
	create_page(dash_set_tab, dash_timers, "Timers", MEDIUM_PAGE)
	
	create_simple_slider("Tempo do dash", 0.1, 1, 0.01, stats.DASH_STATS, "dash_time", dash_timers,
		"Tempo de duração do dash.")
	create_simple_slider("Cooldown do dash", 0.1, 3, 0.01, stats.DASH_STATS, "dash_cooldown", dash_timers,
		"Tempo de recarga do dash.")
#endregion
#endregion
	
	var settings = SETTINGS_SCENE.instantiate()
	create_page(selection_tab, settings, "Configurações", LARGE_PAGE)
