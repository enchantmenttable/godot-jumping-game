extends Node2D

func got_jumped():
	Messenger.enemy_gets_jumped.emit("Enemy-Normal")
	_die()

func _die():
	queue_free()
