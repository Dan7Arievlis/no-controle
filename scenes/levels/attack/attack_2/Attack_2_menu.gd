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
	create_label("Corrida", speed_page)
	create_label("Velocidade de corrida: %.02f" % stats.MOVEMENT_STATS.run_speed, speed_page)
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
	
	create_label("Força do dash: %.02f" % stats.DASH_STATS.dash_force, dash_impulse_page,
		"Influencia a velocidade do dash")
	create_label("Controles direcionais", dash_impulse_page)
	create_label("Dash com uma direção habilitado", dash_impulse_page,
		"Quando desabilitado, permite o jogador executar dash em 8 direções diferentes.")
	create_label("Salvar última horizontal habilitado", dash_impulse_page,
		"Quando habilitado, permite executar um dash horizontal mesmo quando o jogador estiver parado.")
#endregion
	
#region Timers
	var dash_timers = PAGE_COMPONENT.instantiate()
	create_page(dash_set_tab, dash_timers, "Timers", MEDIUM_PAGE)
	
	create_label("Tempo do dash: %.02f" % stats.DASH_STATS.dash_time, dash_timers,
		"Tempo de duração do dash.")
	create_label("Cooldown do dash: %.02f" % stats.DASH_STATS.dash_cooldown, dash_timers,
		"Tempo de recarga do dash.")
#endregion
#endregion
	
#region Attacks Page
	var attacks_page = PAGE_COMPONENT.instantiate()
	create_page(selection_tab, attacks_page, "Ataques", LARGE_PAGE)
	
	var attacks_set_tab = TAB_COMPONENT.instantiate()
	create_tab(attacks_set_tab, attacks_page)
	
#region Melee Page
	var melee_page = PAGE_COMPONENT.instantiate()
	create_page(attacks_set_tab, melee_page, "Corpo a corpo", MEDIUM_PAGE_PLUS)
	
	create_toggle_button("Habilitar ataque corpo a corpo", stats.MELEE_ATTACK_STATS, "enable_melee_attack", melee_page)
	create_label("Dano corpo a corpo: %d" % stats.MELEE_ATTACK_STATS.melee_damage, melee_page)
	
	#var melee_set_tab = TAB_COMPONENT.instantiate()
	#create_tab(melee_set_tab, melee_page)
	
#region Timers Page
	#var melee_timers_page = PAGE_COMPONENT.instantiate()
	#create_page(melee_set_tab, melee_timers_page, "Timers", SMALL_PAGE)
	#
	#create_simple_slider("Tempo do ataque", 0.01, 0.5, 0.01, stats.MELEE_ATTACK_STATS, "swing_time", melee_timers_page)
	#create_simple_slider("Buffer de input de ataque", 0.01, 0.5, 0.01, stats.MELEE_ATTACK_STATS, "swing_buffer", melee_timers_page,
		#"Determina o tempo, em segundos, que a ação de ataque pode ser identificada como input mesmo quando não estiver recarregada.")
	#create_simple_slider("Cooldown de ataque", 0.01, 2, 0.01, stats.MELEE_ATTACK_STATS, "swing_cooldown", melee_timers_page,
		#"Tempo de recarga para ataque corpo a corpo.")
#endregion
	
#region Knockback Page
	#var melee_knockback_page = PAGE_COMPONENT.instantiate()
	#create_page(melee_set_tab, melee_knockback_page, "Knockbacks", SMALL_PAGE)
	
	create_label("Knockbacks", melee_page)
	
	#create_simple_slider("Força de knockback", 0, 1000, 1, stats.MELEE_HITBOX_STATS, "knockback_force", melee_page,
		#"Força exercida pelos acertos de ataques em inimigos.")
	#create_simple_slider("Recuo de ataque", 0, 200, 1, stats.MELEE_ATTACK_STATS, "swing_recoil", melee_page,
		#"Força exercida sobre o jogador quando não acerta os ataques.")
	#create_simple_slider("Recuo de acerto", 0, 300, 1, stats.MELEE_ATTACK_STATS, "strike_recoil", melee_page,
		#"Força exercida sobre o jogador quando acerta os ataques.")
	create_simple_slider("Força do pogo", 200, 800, 1, stats.MELEE_ATTACK_STATS, "pogo_force", melee_page,
		"Força exercida sobre o jogador quando não acerta ataques em entidades que permitem pogo.")
#endregion
#endregion
	
#region Ranged Page
	#var ranged_page = PAGE_COMPONENT.instantiate()
	#create_page(attacks_set_tab, ranged_page, "À distância", MEDIUM_PAGE_PLUS)
	#
	#create_toggle_button("Habilitar ataque à distância", stats.RANGED_ATTACK_STATS, "enable_ranged_attack", ranged_page)
	#create_simple_slider("Dano", 1, 5, 1, stats.PROJECTILE_STATS, "damage", ranged_page)
	#
	#var ranged_set_tab = TAB_COMPONENT.instantiate()
	#create_tab(ranged_set_tab, ranged_page)
	
#region Projectile Page
	#var projectile_page = PAGE_COMPONENT.instantiate()
	#create_page(ranged_set_tab, projectile_page, "Projétil", SMALL_PAGE)
	#
	#create_simple_slider("Tempo de vida", 0.1, 5, 0.1, stats.PROJECTILE_STATS, "life_time", projectile_page,
		#"Tempo que o projétil permanecerá ativo antes de ser destruído.")
	#create_simple_slider("Vida do projétil", 1, 5, 1, stats.PROJECTILE_STATS, "life", projectile_page,
		#"Quantas vezes o projétil poderá atingir algo antes de ser destruída.")
	#create_simple_slider("Velocidade", 10, 800, 1, stats.PROJECTILE_STATS, "speed", projectile_page)
	#create_simple_slider("Gravidade", 0, 2.5, 0.01, stats.PROJECTILE_STATS, "gravity", projectile_page,
		#"Taxa de influência da gravidade sobre o projétil.")
	#create_simple_slider("Força de knockback", 0, 500, 10, stats.PROJECTILE_STATS, "knockback_force", projectile_page,
		#"Força exercida pelos acertos de ataques em inimigos.")
#endregion
	
#region Cannon Page
	#var cannon_page = PAGE_COMPONENT.instantiate()
	#create_page(ranged_set_tab, cannon_page, "Canhão", SMALL_PAGE)
	#
	#create_simple_slider("Tempo de recarga", 0.01, 2, 0.01, stats.CANNON_STATS, "reload_time", cannon_page)
	#create_simple_slider("Coice", 0, 200, 1, stats.CANNON_STATS, "recoil", cannon_page,
		#"Força exercida sobre o jogador quando realizar um ataque à distância parado.")
	#create_simple_slider("Munição máxima", -1, 5, 1, stats.CANNON_STATS, "max_ammo", cannon_page,
		#"Munição máxima do jogador. Quando for igual a -1, considera-se que o jogador possui munição infinita.")
#endregion
	
#region Directions Page
	#var directions_page = PAGE_COMPONENT.instantiate()
	#create_page(ranged_set_tab, directions_page, "Direções de ataque", SMALL_PAGE)
	#
	#create_toggle_button("4 direções", stats.RANGED_ATTACK_STATS, "_4_directions", directions_page,
		#"Quando habilitado, permite executar ataques à distância em 4 direções.")
	#create_toggle_button("8 direções", stats.RANGED_ATTACK_STATS, "_8_directions", directions_page,
		#"Quando habilitado, permite executar ataques à distância em 8 direções.")
#endregion
#endregion
#endregion
	
	var settings = SETTINGS_SCENE.instantiate()
	create_page(selection_tab, settings, "Configurações", LARGE_PAGE)
