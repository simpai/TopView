extends Resource

class_name Inventory

signal updated

@export var slots : Array[InventorySlot]

func insert(item : InventoryItem):
	for i in range(slots.size()):
		if slots[i].item == item:
			if slots[i].amount == item.maxStackAmount:
				continue;
			slots[i].amount += 1 
			updated.emit()
			return

	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1 
			updated.emit()
			return
