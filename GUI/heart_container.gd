extends HBoxContainer

@onready var heartGuiClass = preload("res://GUI/heart.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setMaxHearts(max: int):
	for i in range(max):
		var heart = heartGuiClass.instantiate()
		add_child(heart)

func updateHearts(currentHealth: int):
	var hearts = get_children()

	for i in range(hearts.size()):
		if i < currentHealth:
			hearts[i].update(true)
		else:
			hearts[i].update(false)
	
