extends Node2D
#
#var id
#
#func _ready():
	#id = get_instance_id()
func got_jumped():
	Messenger.enemy_gets_jumped.emit()
	queue_free()
