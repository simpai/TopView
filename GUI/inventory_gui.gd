extends Control

var isOpen: bool = false

@onready var inventory : Inventory = preload("res://resource/playerInventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.updated.connect(update)
	update()

#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		print("Update")
#		update()

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false
	



