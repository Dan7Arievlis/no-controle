# LevelResource.gd
class_name LevelResource
extends Resource

@export var title : String
@export_multiline var description : String
@export var level_scene : PackedScene
@export var stats : PlayerStats
@export var done : bool
