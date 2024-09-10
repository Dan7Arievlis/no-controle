class_name Corner
extends Node2D

@export var size = 10
@export var pos_inner_rays: Vector2 = Vector2.ZERO

@onready var up_outer_ray: RayCast2D = $up_outer_ray
@onready var up_inner_ray: RayCast2D = $up_inner_ray
#@onready var side_outer_ray: RayCast2D = $side_outer_ray
#@onready var side_inner_ray: RayCast2D = $side_inner_ray


func _ready():
	up_outer_ray.target_position *= size
	up_inner_ray.target_position *= size
	#side_outer_ray.target_position *= size
	#side_inner_ray.target_position *= size


func relocate(amount: int):
	up_inner_ray.position.x = pos_inner_rays.x * amount
	#side_inner_ray.position.y = pos_inner_rays.y * amount
