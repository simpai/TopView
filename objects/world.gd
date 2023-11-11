extends Node2D

@onready var heart_container = $CanvasLayer/heartContainer
@onready var player = $TileMap/player

func _ready():
	heart_container.setMaxHearts(player.maxHealth)
	heart_container.updateHearts(player.currentHealth)
	
	player.healthChanged.connect(heart_container.updateHearts)
