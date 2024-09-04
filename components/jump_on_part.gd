extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var parent = get_owner()


func _player_bounce(body, padding):
	body.velocity.y = 0
	#if padding > 0:
		#body.global_position.y -= padding/4
	body.velocity.y = -Settings.bounce_force_multiplier * body.jump_strength


func _on_area_entered(area):
	if area.is_in_group("Player-GiveBox"):
		var player = area.get_owner()
		var padding = player.global_position.y - parent.global_position.y
		print(player.global_position.y - parent.global_position.y)
		_player_bounce(player, padding)
		parent.got_jumped()
		if not player.jumped_once:
			player.jumped_once = true
