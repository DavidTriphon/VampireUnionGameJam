extends Node3D
class_name AttackShoot

const bullet_scene = preload("res://scenes/bullet.tscn")

@export var direction: Vector3 = Vector3(1,0,0):
	set(value):
		direction = value.normalized()
	get:
		return direction
@export var bullet_speed = 20
@export var bullet_dmg = 1

func fire_bullet():
	var bullet = bullet_scene.instantiate()
	print(bullet)
	bullet.position = self.position
	bullet.direction = direction.normalized() * bullet_speed
	get_tree().root.add_child(bullet)
