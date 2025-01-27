extends Node3D
class_name AttackShoot

const bullet_scene = preload("res://scenes/bullet.tscn")

@export var direction: Vector3 = Vector3(1,0,0):
	set(value):
		direction = value.normalized()
	get:
		return direction
@export var bullet_data: BulletData

func with_data(data: ShootData) -> AttackShoot:
	bullet_data = data.bullet_data
	$FiringTimer.wait_time = data.cooldown
	return self

func direction_listener(moved_direction: Vector3):
	# keep as is if X component is 0
	if moved_direction.length() != 0:
		direction = moved_direction

func fire_bullet():
	var bullet = bullet_scene.instantiate().with_dynamics(self.global_position, direction, 2).with_data(bullet_data)
	get_tree().root.add_child(bullet)
