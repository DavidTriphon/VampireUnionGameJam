extends ProgressBar

var level_exp_list = [15, 25, 45, 70]
var current_exp_goal = 0

@export var player_exp = 0
var player_level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_exp():
	player_exp += 1 ## add exp
	max_value = level_exp_list[current_exp_goal]
	value = player_exp
	print("exp is " + str(player_exp))
	if value >= max_value: ## if the bar is filled, the player has leveled up
		level_up()

func level_up():
	current_exp_goal += 1 ## increase what the player should aim for next
	player_level = current_exp_goal
	player_exp = 0 ## reset the current exp
	value = 0
	if current_exp_goal == 1:
		pass
		## first upgrade
	if current_exp_goal == 2:
		pass
		## second upgrade
	if current_exp_goal == 3:
		pass 
		## third upgrade
	if current_exp_goal == 4:
		pass 
		## this is where the game would end
