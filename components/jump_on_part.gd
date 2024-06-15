extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@export var bounce_force_multiplier = 1.4
@onready var parent = get_owner()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		_player_bounce(body)
		parent.got_jumped()

func _player_bounce(body):
	body.velocity.y = 0
	body.velocity.y = -bounce_force_multiplier * body.jump_strength