extends Node
class_name Game

@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var player: Player = $Player
@onready var exp_bar: ExpBar = $ExpBar

@export var spawn_distance = 20
@export var weapon_levels: Array[WeaponProfile]
@export var exp_level_goals: Array[int] = [5, 10, 15, 20]

@export var player_level = 0

func _ready():
	# randomize will set up the RNG for enemy spawning
	randomize()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	# set the first level defaults
	init_level()

func level_up():
	player_level += 1
	init_level()

func init_level():
	# don't try to level up if we're past the end of the constants
	if player_level < exp_level_goals.size():
		player.set_weapons(weapon_levels[player_level])
		exp_bar.set_exp_goal(exp_level_goals[player_level])

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var offset = Vector2(spawn_distance, 0).rotated(randf_range(-PI, PI))
	var offset3 = Vector3(offset.x, 0, offset.y)
	enemy.position = player.position + offset3
	enemy.tree_exited.connect(spawn_enemy)
	enemy.tree_exited.connect(exp_bar.add_exp)
	add_child(enemy)
