extends Area3D
class_name Bullet

@export var direction: Vector3 = Vector3(1,0,0)

func _physics_process(delta: float) -> void:
	position += direction * delta

func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		body.die()
	else:
		print("bullet contacted body that was not an Enemy")
	queue_free()
