extends CharacterBody3D
class_name Player

@export var SPEED = 5.0
@export var bullet_speed = 20

var bullet_scene = preload("res://scenes/bullet.tscn")

var last_direction: Vector3 = Vector3(1, 0, 0)

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

func fire_bullet():
	print(bullet_scene)
	var bullet = bullet_scene.instantiate()
	print(bullet)
	bullet.position = self.position
	bullet.direction = last_direction.normalized() * bullet_speed
	get_tree().root.add_child(bullet)
