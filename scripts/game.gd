extends Node

@export var spawn_distance = 20
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var player_node = get_node("Player")

func _ready():
	randomize()
	spawn_enemy()

func spawn_enemy():
	#print("spawning enemy")
	var enemy = enemy_scene.instantiate()
	var offset = Vector2(spawn_distance, 0).rotated(randf_range(-PI, PI))
	var offset3 = Vector3(offset.x, 0, offset.y)
	enemy.position = player_node.position + offset3
	enemy.tree_exited.connect(spawn_enemy)
	add_child(enemy)
	#print("enemy:")
	#print(enemy)
