extends Node2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Messenger.player_forbidden_touch.emit()
