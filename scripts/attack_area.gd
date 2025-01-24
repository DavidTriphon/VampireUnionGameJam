extends Area3D
class_name AttackArea

@export var damage: int

signal hit_something

func on_area_entered(area: Area3D):
	if area is HitArea:
		if area.health != null:
			area.health.current_health -= damage
		hit_something.emit()
