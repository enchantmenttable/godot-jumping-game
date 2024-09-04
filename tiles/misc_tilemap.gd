extends TileMap

@export var line_group : int

func _ready():
	Messenger.key_acquired.connect(_key_acquired.bind())

func _key_acquired(key_group):
	if line_group == key_group:
		call_deferred("queue_free")
