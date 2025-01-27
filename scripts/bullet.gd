extends CharacterBody3D
class_name Bullet

@onready var attack_area: AttackArea = $AttackArea

# this enables the piercing mechanic for bullets
# counts how many entities this bullet can hit before it destroys itself
@export var collisions_max = 1
var collisions = 0

func with_dynamics(pos, direction, target_mask) -> Bullet:
	position = pos
	velocity = direction
	$AttackArea.collision_mask = target_mask
	return self

func with_data(data: BulletData) -> Bullet:
	collisions_max = data.hits
	$AttackArea.damage = data.damage
	velocity = velocity.normalized() * data.speed
	return self

func _physics_process(delta: float) -> void:
	move_and_slide()

func contacted_hitbox():
	# if the bullet has hit the maximum number of enemies, the bullet despawns.
	collisions += 1
	if collisions >= collisions_max:
		queue_free()
