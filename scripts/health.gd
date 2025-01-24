extends Node
class_name Health

signal dead

@export var max_health: int

var current_health: int:
	get:
		return current_health
	set(value):
		current_health = value
		if value <= 0:
			dead.emit()

func _ready() -> void:
	current_health = max_health
