extends Panel

@onready var resume_button = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Settings/VBoxContainer/ResumeButton
@onready var quit_button = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Settings/VBoxContainer/QuitButton
@onready var player: Player = $"../../Player"
@onready var resolution_button: MenuButton = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Settings/SettingsMenu/HBoxContainer/ResolutionButton
@onready var v_box_container = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Settings/VBoxContainer
@onready var settings_menu = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Settings/SettingsMenu

var movement : MovementResource
var jump : JumpResource
var dash : DashResource
var wall_slide : WallSlideResource
var wall_jump : WallJumpResource
var melee : MeleeAttackResource
var ranged : RangedAttackResource
var camera : CameraResource


func _ready():
	resolution_button.get_popup().id_pressed.connect(resolution_button_selected)
	set_resolution(DisplayServer.screen_get_size())
	if player:
		movement = player.movement_stats
		jump = player.jump_stats
		dash = player.dash_stats
		wall_slide = player.wall_slide_stats
		wall_jump = player.wall_jump_stats
		melee = player.melee_attack_stats
		ranged = player.ranged_attack_stats
		camera = player.camera_stats
	
	#TODO sync os valores iniciais e limites dos sliders com os valores de cada parametro 
	# (incluindo habilitar/desalibitar páginas (acho melhor fazer isso com um arquivo de configuração))
	hide()

#region Movement
func _on_enable_movement_toggled(toggled_on):
	movement.enable_movement = toggled_on


func _on_acceleration_rate_value_changed(value):
	movement.accel_rate = value


func _on_deceleration_rate_value_changed(value):
	movement.decel_rate = value


func _on_air_acceleration_rate_value_changed(value):
	movement.air_accel_rate = value


func _on_air_deceleration_rate_value_changed(value):
	movement.air_decel_rate = value


func _on_high_speed_decel_value_changed(value):
	movement.high_speed_decel = value


func _on_air_high_speed_decel_value_changed(value):
	movement.air_high_speed_decel = value


func _on_walk_speed_value_changed(value):
	movement.walk_speed = value


func _on_enable_run_toggled(toggled_on):
	movement.can_run = toggled_on
	$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Walk/MarginContainer/VBoxContainer/MarginContainer/WalkTabContainer/Speed/MarginContainer/VBoxContainer/RunSpeed.visible = toggled_on

func _on_run_speed_value_changed(value):
	movement.run_speed = value


func _on_turn_speed_value_changed(value):
	movement.turn_speed = value


func _on_air_turn_speed_value_changed(value):
	movement.air_turn_speed = value

#endregion

#region Jump
func _on_enable_jump_toggled(toggled_on):
	jump.enable_jump = toggled_on


func _on_jump_velocity_value_changed(value):
	jump.jump_velocity = value


func _on_can_double_jump_toggled(toggled_on):
	jump.double_jump = toggled_on
	$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Jump/MarginContainer/VBoxContainer/MarginContainer/JumpTabContainer/Impulses/MarginContainer/VBoxContainer/DoubleJumpVelocity.visible = toggled_on
	$PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Jump/MarginContainer/VBoxContainer/MarginContainer/JumpTabContainer/Impulses/MarginContainer/VBoxContainer/JumpWait.visible = toggled_on
	$"PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/TabContainer/Wall Jumping/MarginContainer/VBoxContainer/MarginContainer/WallingTabContainer/Wall Slide/MarginContainer/VBoxContainer/RefreshDoubleJump".visible = toggled_on


func _on_double_jump_velocity_value_changed(value):
	jump.double_jump_velocity = value


func _on_jump_wait_value_changed(value):
	jump.jump_wait = value


func _on_coyote_time_value_changed(value):
	jump.coyote_time = value


func _on_jump_buffer_value_changed(value):
	jump.jump_buffer = value


func _on_max_fall_speed_value_changed(value):
	jump.max_fall_speed = value


func _on_gravity_fall_mult_value_changed(value):
	jump.gravity_fall_multiplier = value


func _on_jump_cut_mult_value_changed(value):
	jump.jump_cut_multiplier = value


func _on_gravity_apex_mult_value_changed(value):
	jump.gravity_apex_multiplier = value


func _on_apex_speed_mult_value_changed(value):
	jump.apex_speed_multiplier = value


func _on_apex_margin_value_changed(value):
	jump.apex_margin = value
#endregion

#region Dash
func _on_enable_dash_toggled(toggled_on):
	dash.enable_dash = toggled_on


func _on_dash_force_value_changed(value):
	dash.dash_force = value


func _on_one_directional_dash_toggled(toggled_on):
	dash.one_directional_dash = toggled_on


func _on_save_last_horizontal_toggled(toggled_on):
	dash.save_last_horizontal = toggled_on


func _on_dash_time_value_changed(value):
	dash.dash_time = value


func _on_dash_cooldown_value_changed(value):
	dash.dash_cooldown = value
#endregion

#region Wall Jumping
func _on_enable_wall_slide_toggled(toggled_on):
	wall_slide.enable_wall_slide = toggled_on


func _on_refresh_double_jump_toggled(toggled_on):
	wall_slide.refresh_double_jump = toggled_on


func _on_wall_friction_value_changed(value):
	wall_slide.wall_friction = value


func _on_max_wall_slide_velocity_value_changed(value):
	wall_slide.max_wall_slide_velocity = value


func _on_enable_wall_jump_toggled(toggled_on):
	wall_jump.enable_wall_jump = toggled_on


func _on_wall_jump_vector_x_value_changed(value):
	wall_jump.wall_jump_vector.x = value


func _on_wall_jump_vector_y_value_changed(value):
	wall_jump.wall_jump_vector.y = value


func _on_wall_jumping_grace_time_value_changed(value):
	wall_jump.wall_jumping_grace_time = value


func _on_jump_off_wall_multiplier_value_changed(value):
	wall_jump.jump_off_wall_multiplier = value
#endregion

#region Attacks

#endregion

#region Settings
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()


func _on_resume_button_pressed():
	toggle_pause()


func toggle_pause():
	visible = not visible
	get_tree().paused = not get_tree().paused
	_on_back_button_pressed()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_pressed():
	v_box_container.visible = false
	settings_menu.visible = true


func _on_back_button_pressed():
	v_box_container.visible = true
	settings_menu.visible = false


func resolution_button_selected(id: int):
	var resolutions = [Vector2(1920, 1080), Vector2(1080, 720)]
	set_resolution(resolutions[id])


func set_resolution(resolution: Vector2):
	get_viewport().size = resolution
	resolution_button.text = str(resolution.x) + "x" + str(resolution.y)
#endregion


func _on_enable_melee_attack_toggled(toggled_on: bool) -> void:
	melee.enable_melee_attack = toggled_on
