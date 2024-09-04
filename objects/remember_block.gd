extends Node2D

var active = false

@onready var anim = $AnimatedSprite2D

func _on_activation_trigger_area_entered(area):
	if area.is_in_group("Player-GiveBox"):
		_player_pass(area)

func _player_pass(area):
	if active:
		var player = area.get_owner()
		player.die()
	else:
		active = true
		anim.play("active")
