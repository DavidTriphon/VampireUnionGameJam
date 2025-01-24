extends Node3D

@export var last_dir_is_right: bool = true
@export var is_attacking_both: bool = false

@onready var attack_area_left: AttackArea = $AttackAreaLeft
@onready var attack_area_right: AttackArea = $AttackAreaRight

func attack():
	if is_attacking_both:
		attack_area_right.attack_now()
		attack_area_left.attack_now()
	else:
		if last_dir_is_right:
			attack_area_right.attack_now()
		else:
			attack_area_left.attack_now()
