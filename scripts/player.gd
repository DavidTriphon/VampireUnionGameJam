extends CharacterBody3D
class_name Player

signal direction_changed(new_direction)

@export var SPEED = 5.0
@export_range(1,4) var stage = 1:
	set(value):
		value = clamp(value, 1, 4)
		if stage != value:
			stage = value
			update_anim_state()
@export var is_running: bool = false:
	set(value):
		if is_running != value:
			is_running = value
			update_anim_state()

@onready var attack_melee: AttackMelee = $AttackMelee
@onready var attack_shoot: AttackShoot = $AttackShoot
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D

const STAGE_ANIMS := {
	1: {"idle": "s1_idle", "run":"s1_run"},
	2: {"idle": "s2_idle", "run":"s2_run"},
	3: {"idle": "s3_idle", "run":"s3_run"},
	4: {"idle": "s4_idle", "run":"s4_idle"},
}

func update_anim_state():
	animated_sprite_3d.play(STAGE_ANIMS[stage]["run" if is_running else "idle"])

var last_direction: Vector3 = Vector3(1, 0, 0):
	set(value):
		if last_direction != value:
			last_direction = value
			direction_changed.emit(value)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		is_running = true
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		last_direction = direction
		# make sure anim is flipped based on direction
		if velocity.x < 0:
			animated_sprite_3d.flip_h = true
		elif velocity.x > 0:
			animated_sprite_3d.flip_h = false
	else:
		is_running = false
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func set_weapons(weapon_profile: WeaponProfile):
	# a lack of data for a weapon implies that weapon is disabled for this preset
	# melee
	if weapon_profile.melee_data != null:
		attack_melee.with_data(weapon_profile.melee_data)
		attack_melee.set_process_mode(Node.PROCESS_MODE_INHERIT)
	else:
		attack_melee.set_process_mode(Node.PROCESS_MODE_DISABLED)

	# shooting
	if weapon_profile.shoot_data != null:
		attack_shoot.with_data(weapon_profile.shoot_data)
		attack_shoot.set_process_mode(Node.PROCESS_MODE_INHERIT)
	else:
		attack_shoot.set_process_mode(Node.PROCESS_MODE_DISABLED)
