extends CharacterBody3D
class_name Bullet

@export var collisions_left = 1

func _physics_process(delta: float) -> void:
	move_and_slide()

func contacted_hitbox():
	collisions_left -= 1
	if collisions_left == 0:
		queue_free()
