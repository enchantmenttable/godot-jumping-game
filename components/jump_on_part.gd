extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var parent = get_owner() # enemy

var bounce_force_muliplier_mod = Settings.bounce_force_multiplier


func _player_bounce(body, padding):
	print("jump on part, global position body - enemy: ", body.global_position.y - parent.global_position.y)

	body.velocity.y = 0

	if padding > 0:
		bounce_force_muliplier_mod *= 1.1
	elif padding < 0:
		bounce_force_muliplier_mod *= .9

	body.velocity.y = -bounce_force_muliplier_mod * body.jump_strength

	body.emit_jump_particle()
	"""
	method 1:
		< 0 -> lower bounce force multiplier
		> 0 -> higher
	"""

func _on_area_entered(area):
	if area.is_in_group("Player-GiveBox"):
		var player = area.get_owner()
		var padding = player.global_position.y - parent.global_position.y
		_player_bounce(player, padding)
		parent.got_jumped()
		if not player.jumped_once:
			player.jumped_once = true
		collision_shape_2d.set_deferred("disabled", true)
