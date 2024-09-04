extends Node2D

@export var block_group : int

func _ready():
	Messenger.key_acquired.connect(_key_acquired.bind())

func _key_acquired(key_group):
	if block_group == key_group:
		call_deferred("queue_free")


func _on_area_2d_body_entered(body): # TODO: ?
	if body.is_in_group("Player"):
		Messenger.player_forbidden_touch.emit()
