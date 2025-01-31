extends Node
class_name Game

const BAT = preload("res://scenes/entities/bat.tscn")
const LEECH = preload("res://scenes/entities/leech.tscn")
const VAMPIRE = preload("res://scenes/entities/vampire.tscn")

const ENEMIES = [BAT, LEECH, VAMPIRE]

@onready var player: Player = $Player
@onready var exp_bar: ExpBar = $ExpBar
@onready var spawn_positions := $SpawnLocs.get_children().map(func(node3d: Node3D): return node3d.position)

@export var spawn_enemy_count = 5
@export var spawn_distance = 10
@export var weapon_levels: Array[WeaponProfile]
@export var exp_level_goals := [5, 10, 15, 20]
@export var level_player_stages := [1, 2, 3, 4]

@export var player_level = 0

func _ready():
	# randomize will set up the RNG for enemy spawning
	randomize()
	for i in range(spawn_enemy_count):
		spawn_enemy()
	# set the first level defaults
	init_level()

func level_up():
	player_level += 1
	init_level()

func init_level():
	# don't try to level up if we're past the end of the constants
	if player_level < exp_level_goals.size():
		player.stage = level_player_stages[player_level]
		player.set_weapons(weapon_levels[player_level])
		exp_bar.set_exp_goal(exp_level_goals[player_level])

func spawn_enemy():
	var enemy = ENEMIES.pick_random().instantiate()
	var valid_spawns = spawn_positions.filter(func(pos: Vector3): return (pos-player.global_position).length() >= spawn_distance)
	enemy.position = valid_spawns.pick_random()
	enemy.tree_exited.connect(spawn_enemy)
	enemy.tree_exited.connect(exp_bar.add_exp)
	add_child(enemy)
