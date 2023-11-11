extends "res://objects/collectables/collectable.gd"

@onready var animation_player = $AnimationPlayer

func collect(inventory:Inventory):
	animation_player.play("spin")
	await animation_player.animation_finished
	super.collect(inventory)
