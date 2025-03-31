class_name PlayerStats
extends Resource

@export var CAMERA_STATS : CameraResource :
	set(stats):
		if stats:
			BACKUP_CAMERA_STATS = stats.duplicate() as CameraResource
	get():
		return BACKUP_CAMERA_STATS
@export var CANNON_STATS : CannonStats :
	set(stats):
		if stats:
			BACKUP_CANNON_STATS = stats.duplicate() as CannonStats
	get():
		return BACKUP_CANNON_STATS
@export var DASH_STATS : DashResource :
	set(stats):
		if stats:
			BACKUP_DASH_STATS = stats.duplicate() as DashResource
	get():
		return BACKUP_DASH_STATS
@export var JUMP_STATS : JumpResource :
	set(stats):
		if stats:
			BACKUP_JUMP_STATS = stats.duplicate() as JumpResource
	get():
		return BACKUP_JUMP_STATS
var MELEE_HITBOX_STATS : HitboxStats :
	get():
		return BACKUP_MELEE_HITBOX_STATS
@export var MELEE_ATTACK_STATS : MeleeAttackResource :
	set(stats):
		if stats:
			BACKUP_MELEE_ATTACK_STATS = stats.duplicate() as MeleeAttackResource
			BACKUP_MELEE_HITBOX_STATS = HitboxStats.new(BACKUP_MELEE_ATTACK_STATS.melee_damage, BACKUP_MELEE_ATTACK_STATS.knockback_force)
	get():
		return BACKUP_MELEE_ATTACK_STATS
@export var MOVEMENT_STATS : MovementResource :
	set(stats):
		if stats:
			BACKUP_MOVEMENT_STATS = stats.duplicate() as MovementResource
	get():
		return BACKUP_MOVEMENT_STATS
@export var PROJECTILE_STATS : ProjectileStats :
	set(stats):
		if stats:
			BACKUP_PROJECTILE_STATS = stats.duplicate() as ProjectileStats
	get():
		return BACKUP_PROJECTILE_STATS
@export var RANGED_ATTACK_STATS : RangedAttackResource :
	set(stats):
		if stats:
			BACKUP_RANGED_ATTACK_STATS = stats.duplicate() as RangedAttackResource
	get():
		return BACKUP_RANGED_ATTACK_STATS
@export var WALL_CLIMB_STATS : WallClimbResource :
	set(stats):
		if stats:
			BACKUP_WALL_CLIMB_STATS = stats.duplicate() as WallClimbResource
	get():
		return BACKUP_WALL_CLIMB_STATS
@export var WALL_JUMP_STATS : WallJumpResource :
	set(stats):
		if stats:
			BACKUP_WALL_JUMP_STATS = stats.duplicate() as WallJumpResource
	get():
		return BACKUP_WALL_JUMP_STATS
@export var WALL_SLIDE_STATS : WallSlideResource :
	set(stats):
		if stats:
			BACKUP_WALL_SLIDE_STATS = stats.duplicate() as WallSlideResource
	get():
		return BACKUP_WALL_SLIDE_STATS

var BACKUP_CAMERA_STATS : CameraResource
var BACKUP_CANNON_STATS : CannonStats
var BACKUP_DASH_STATS : DashResource
var BACKUP_JUMP_STATS : JumpResource
var BACKUP_MELEE_ATTACK_STATS : MeleeAttackResource
var BACKUP_MELEE_HITBOX_STATS : HitboxStats
var BACKUP_MOVEMENT_STATS : MovementResource
var BACKUP_PROJECTILE_STATS : ProjectileStats
var BACKUP_RANGED_ATTACK_STATS : RangedAttackResource
var BACKUP_WALL_CLIMB_STATS : WallClimbResource
var BACKUP_WALL_JUMP_STATS : WallJumpResource
var BACKUP_WALL_SLIDE_STATS : WallSlideResource
