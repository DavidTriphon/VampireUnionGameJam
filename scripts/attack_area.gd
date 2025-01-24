extends Area3D
class_name AttackArea

@export var damage: int
# hit_on_enter controls whether attacks should occur when a hitarea begins to overlap an attackarea.
# Changing this variable after readying will do nothing.
@export var hit_on_enter: bool = true

signal hit_something

func _ready():
	if hit_on_enter:
		area_entered.connect(try_apply_damage)

func try_apply_damage(area: Area3D):
	if area is HitArea:
		if area.health != null:
			area.health.current_health -= damage
		hit_something.emit()

# scan for all overlapping hitareas at this moment and hit only now
func attack_now():
	var areas = get_overlapping_areas()
	for area in areas:
		try_apply_damage(area)
