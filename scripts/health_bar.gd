extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fill_mode = 3 ## sets it so this fills up from bottom to top

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
