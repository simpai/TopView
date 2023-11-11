extends Area2D


func collect():
	get_parent().queue_free()
