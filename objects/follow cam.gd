extends Camera2D

@export var tile_map : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var mapRect = tile_map.get_used_rect()
	var mapSizeInPixel = mapRect.size * tile_map.cell_quadrant_size
	limit_left = 0
	limit_right = 0
	limit_right = mapSizeInPixel.x
	limit_bottom = mapSizeInPixel.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
