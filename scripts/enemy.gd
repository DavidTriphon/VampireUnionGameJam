extends CharacterBody3D
class_name Enemy

@export var SPEED = 5.0

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
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func die():
	var exp_node = get_node("/root/Game/ExpBar")
	exp_node.add_exp()
	#print("exp node is " + str(exp_node))
	queue_free()
