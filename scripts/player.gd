extends CharacterBody3D
class_name Player

signal direction_changed(new_direction)

@export var SPEED = 5.0

@onready var attack_melee: AttackMelee = $AttackMelee
@onready var attack_shoot: AttackShoot = $AttackShoot

var last_direction: Vector3 = Vector3(1, 0, 0):
	set(value):
		last_direction = value
		direction_changed.emit(value)
	get:
		return last_direction

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		last_direction = direction
	else:
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
