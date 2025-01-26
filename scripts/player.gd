extends CharacterBody3D
class_name Player

@export var SPEED = 5.0

signal direction_changed(new_direction)

var last_direction: Vector3 = Vector3(1, 0, 0):
	set(value):
		last_direction = value
		direction_changed.emit(value)
	get:
		return last_direction

func _ready():
	pass

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
