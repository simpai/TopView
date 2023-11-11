extends CanvasLayer

@onready var inventory_gui = $InventoryGui

func _ready():
	inventory_gui.close()
	
func _input(event):
	if event.is_action_pressed("inventory"):
		if inventory_gui.isOpen:
			inventory_gui.close()
		else:
			inventory_gui.open()
