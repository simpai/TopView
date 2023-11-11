extends Node2D

var weapon : Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_children().is_empty(): return
	weapon = get_children()[0]

func enable():
	if weapon == null: return
	weapon.enable()
	visible = true
	
func disable():
	if weapon == null: return
	weapon.disable()
	visible = false
