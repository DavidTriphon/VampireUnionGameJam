extends CharacterBody3D
class_name Enemy

@export var SPEED = 5.0

@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# Will always move directly towards player character
	var players = get_tree().get_nodes_in_group("player")
	var direction := Vector3()
	if players.size() > 0:
		var player = players[0]
		var player_vector: Vector3 = player.position - self.position
		player_vector.y = 0
		direction = player_vector.normalized()
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		if velocity.x > 0:
			animated_sprite_3d.flip_h = true
		elif velocity.x < 0:
			animated_sprite_3d.flip_h = false
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func die():
	queue_free()
