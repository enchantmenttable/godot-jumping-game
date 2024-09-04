extends Node2D

@export var key_group : int

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		Messenger.key_acquired.emit(key_group)
		_key_acquired()

func _key_acquired():
	call_deferred("queue_free")
