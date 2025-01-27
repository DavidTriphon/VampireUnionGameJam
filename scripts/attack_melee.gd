extends Node3D
class_name AttackMelee

@export var last_dir_is_right: bool = true
@export var is_attacking_both: bool = false

@onready var attack_area_right: AttackArea = $AttackAreaRight
@onready var csg_right: CSGCylinder3D = $AttackAreaRight/CSGRight
@onready var attack_area_left: AttackArea = $AttackAreaLeft
@onready var csg_left: CSGCylinder3D = $AttackAreaLeft/CSGLeft
@onready var visibility_timer: Timer = $VisibilityTimer
@onready var attack_timer: Timer = $AttackTimer

func with_data(data: MeleeData) -> AttackMelee:
	is_attacking_both = data.both
	attack_timer.wait_time = data.cooldown
	attack_area_left.damage = data.damage
	attack_area_right.damage = data.damage
	return self

func direction_listener(direction: Vector3):
	# axis of left/right is the X axis
	# right is positive X, left is negative X
	
	# keep as is if X component is 0
	if direction.x > 0:
		last_dir_is_right = true
	elif direction.x < 0:
		last_dir_is_right = false

func attack():
	if is_attacking_both:
		attack_right()
		attack_left()
	else:
		if last_dir_is_right:
			attack_right()
		else:
			attack_left()

func attack_right():
	attack_area_right.attack_now()
	csg_right.set_visible(true)
	visibility_timer.start()

func attack_left():
	attack_area_left.attack_now()
	csg_left.set_visible(true)
	visibility_timer.start()
