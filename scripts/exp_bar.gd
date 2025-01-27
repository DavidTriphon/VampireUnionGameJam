extends ProgressBar
class_name ExpBar

signal levelled_up()

func set_exp_goal(val: int):
	max_value = val

func add_exp(to_add=1):
	value += to_add ## add exp
	print("exp is " + str(value))
	if value >= max_value: ## if the bar is filled, the player has leveled up
		level_up()

func level_up():
	value -= max_value ## reset the current exp and carryover spare exp
	levelled_up.emit()
