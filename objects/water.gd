extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.velocity.y = 40
		Settings.current_gravity = Settings.GRAVITY_WATER

func _on_body_exited(body):
	if body.is_in_group("Player"):
		Settings.current_gravity = Settings.BASE_GRAVITY
