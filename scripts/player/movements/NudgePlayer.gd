extends Node

signal nudge_player(amount: Vector2)

@export var nudge_amount: int = 4

@onready var right_upper_corner: Corner = $Corner1
@onready var left_upper_corner: Corner = $Corner2
@onready var right_bottom_corner: Corner = $Corner3
@onready var left_bottom_corner: Corner = $Corner4

func _ready():
	right_upper_corner.relocate(nudge_amount)
	left_upper_corner.relocate(nudge_amount)
	right_bottom_corner.relocate(nudge_amount)
	left_bottom_corner.relocate(nudge_amount)
		

func _physics_process(_delta):
	if _check_up(left_upper_corner, right_upper_corner):
		nudge_player.emit(Vector2(left_upper_corner.up_inner_ray.position.x, 0))
	elif _check_up(right_upper_corner, left_upper_corner):
		nudge_player.emit(Vector2(right_upper_corner.up_inner_ray.position.x, 0))
	
	#if _check_side(left_upper_corner, right_upper_corner):
		#nudge_player.emit(Vector2(0, left_upper_corner.side_inner_ray.position.y))
	#elif _check_side(right_upper_corner, left_upper_corner):
		#nudge_player.emit(Vector2(0, right_upper_corner.side_inner_ray.position.y))
	#elif _check_side(left_bottom_corner, right_bottom_corner):
		#nudge_player.emit(Vector2(0, left_bottom_corner.side_inner_ray.position.y))
	#elif _check_side(right_bottom_corner, left_bottom_corner):
		#nudge_player.emit(Vector2(0, right_bottom_corner.side_inner_ray.position.y))


func _check_up(corner, opposite_corner):
	return corner.up_outer_ray.is_colliding() and !corner.up_inner_ray.is_colliding() \
		and !opposite_corner.up_outer_ray.is_colliding() and !opposite_corner.up_inner_ray.is_colliding()


func _check_side(corner, opposite_corner):
	return corner.side_outer_ray.is_colliding() and !corner.side_inner_ray.is_colliding() \
		and !opposite_corner.side_outer_ray.is_colliding() and !opposite_corner.side_inner_ray.is_colliding()
