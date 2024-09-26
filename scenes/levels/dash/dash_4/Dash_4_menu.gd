extends MenuComponentCreator


func draw_menu(stats : PlayerStats):
	var selection_tab = TAB_COMPONENT.instantiate()
	create_tab(selection_tab)
	
#region Movement Page
	var movement_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, movement_page, "Movimento", LARGE_PAGE)
	
	create_label("Movimento habilitado", movement_page)
	
	var movement_set_tab = TAB_COMPONENT.instantiate()
	create_tab(movement_set_tab, movement_page)
	
#region Speed Page
	var speed_page = PAGE_COMPONENT.instantiate()
	create_page(movement_set_tab, speed_page, "Velocidade", MEDIUM_PAGE)
	
	create_label("Velocidade de caminhada: %.02f" % stats.MOVEMENT_STATS.walk_speed, speed_page,
		"Velocidade máxima que pode se alcançar ao caminhar.")
	create_label("Velocidade de virada: %.02f" % stats.MOVEMENT_STATS.turn_speed, speed_page,
		"Influencia no tempo para que a direção de movimento se iguale à direção do input enquanto no chão.")
	create_label("Velocidade de virada no ar: %.02f" % stats.MOVEMENT_STATS.air_turn_speed, speed_page, 
		"Influencia no controle de movimento aéreo. Valores baixos fixam a tajetória no ar em relação à direção do primeiro momento no ar.")
	create_label("Corrida desabilitada", speed_page)
#endregion
	
#region Acceleration page
	var acceleration_page = PAGE_COMPONENT.instantiate()
	create_page(movement_set_tab, acceleration_page, "Aceleração", MEDIUM_PAGE)
	
	create_label("Taxa de aceleração: %.02f" % stats.MOVEMENT_STATS.accel_rate, acceleration_page,
		"Influencia o tempo para alcançar a velocidade máxima enquanto estiver no chão.")
	create_label("Taxa de desaceleração: %.02f" % stats.MOVEMENT_STATS.decel_rate, acceleration_page,
		"Influencia o tempo para se manter estacionário enquanto estiver no chão.")
	create_label("Taxa de aceleração no ar: %.02f" % stats.MOVEMENT_STATS.air_accel_rate, acceleration_page,
		"Influencia o tempo para alcançar a velocidade máxima enquanto estiver no ar.")
	create_label("Taxa de desaceleração no ar: %.02f" % stats.MOVEMENT_STATS.air_decel_rate, acceleration_page,
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
	
	create_label("Velocidade do pulo: %.02f" % stats.JUMP_STATS.jump_velocity, impulses_page, 
		"Influencia na altura máxima que um pulo poderá alcançar")
	create_label("Tempo de Coiote e Buffer de Pulo", impulses_page)
	create_label("Tempo de Coiote: %.02f" % stats.JUMP_STATS.coyote_time, impulses_page,
		"Determina o tempo, em segundos, que a ação de pulo pode ser identificada como input mesmo após o personagem deixar o chão.")
	create_label("Buffer de tempo: %.02f" % stats.JUMP_STATS.jump_buffer, impulses_page,
		"Determina o tempo, em segundos, que a ação de pulo pode ser identificada como input quando executada logo antes de alcançar o chão novamente.")
	create_label("Pulo duplo desabilitado", impulses_page)
	create_trigger("double_jump", create_label("Pulo duplo habilitado", impulses_page))
	create_label("Velocidade de pulo duplo: %.02f" % stats.JUMP_STATS.double_jump_velocity, impulses_page,
		"Influencia na altura máxima que um segundo pulo executado no ar poderá alcançar.")
	create_label("Espera para pulo: %.02f" % stats.JUMP_STATS.jump_wait, impulses_page,
		"Tempo de delay para efetivação do segundo pulo.")
#endregion
	
#region Falling
	var falling_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, falling_page, "Queda", MEDIUM_PAGE)
	
	create_label("Velocidade máxima de queda: %.02f" % stats.JUMP_STATS.max_fall_speed, falling_page)
	create_label("Modificadores de gravidade", falling_page)
	create_label("Multiplicador de gravidade na queda: %.02f" % stats.JUMP_STATS.gravity_fall_multiplier, falling_page,
		"Altera o comportamento da gravidade em um personagem em queda, recomendado para que não passe a sensação que está flutuando.")
	create_label("Multiplicador para corte do pulo: %.02f" % stats.JUMP_STATS.jump_cut_multiplier, falling_page,
		"Afeta a altura do pulo ao soltar o botão de pulo durante a subida. Quando o multiplicador está em 0, a velocidade do pulo é cortada imediatamente e o personagem começa a cair no mesmo instante; quando o multiplicador é 1, o pulo permanece inalterado mesmo se o botão for liberado.")
#endregion
	
#region Apex
	var apex_page = PAGE_COMPONENT.instantiate()
	create_page(jump_set_tab, apex_page, "Ápice", MEDIUM_PAGE)
	
	create_label("Multiplicador de gravidade no ápice: %.02f" % stats.JUMP_STATS.gravity_apex_multiplier, apex_page,
		"Diminui a velocidade de queda do personagem enquando estiver no ápice do pulo.")
	create_label("Multiplicador de velocidade no ápice: %.02f" % stats.JUMP_STATS.apex_speed_multiplier, apex_page,
		"Aumenta a velocidade horizontal do personagem enquanto estiver no ápice do pulo.")
	create_label("Margem de ápice: %.02f" % stats.JUMP_STATS.apex_margin, apex_page, 
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
	create_label("Atualizar pulo duplo habilitado", wall_slide_page,
		"Quando habilitado, atualiza o pulo duplo do personagem, possibilitando executar sempre que pular de uma parede.")
	create_label("Velocidade máxima de deslize: %.02f" % stats.WALL_SLIDE_STATS.max_wall_slide_velocity, wall_slide_page)
	create_label("Fricção da parede: %.02f" % stats.WALL_SLIDE_STATS.wall_friction, wall_slide_page,
		"Influencia no tempo para alcançar a velocidade máxima de deslize na parede")
#endregion
	
#region Wall Jump
	var wall_jump_page = PAGE_COMPONENT.instantiate()
	create_page(wall_jumping_tab, wall_jump_page, "Pulo na parede", MEDIUM_PAGE_PLUS)
	
	create_toggle_button("Habilitar pulo na parede", stats.WALL_JUMP_STATS, "enable_wall_jump", wall_jump_page)
	create_label("Vetor do pulo: %s" % stats.WALL_JUMP_STATS.wall_jump_vector, wall_jump_page,
		"Diração e intensidade nas quais o pulo na parede é feito.")
	#create_simple_slider("Tempo de tolerância para pulo", 0, 0.5, 0.01, stats.WALL_JUMP_STATS, "wall_jumping_grace_time", wall_jump_page)
	create_label("Multiplicador de velocidade de ejeção: %.02f" % stats.WALL_JUMP_STATS.jump_off_wall_multiplier, wall_jump_page,
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
	create_label("Dash com uma direção habilitado", dash_impulse_page,
		"Quando desabilitado, permite o jogador executar dash em 8 direções diferentes.")
	create_label("Salvar última horizontal habilitado", dash_impulse_page,
		"Quando habilitado, permite executar um dash horizontal mesmo quando o jogador estiver parado.")
#endregion
#endregion
	
	var settings = SETTINGS_SCENE.instantiate()
	create_page(selection_tab, settings, "Configurações", LARGE_PAGE)
