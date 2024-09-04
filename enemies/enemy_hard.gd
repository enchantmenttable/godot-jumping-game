extends Node2D

@onready var collision_shape_2d = $Body/JumpOnPart/CollisionShape2D
@onready var anim = $Body/AnimatedSprite2D

enum {TANGIBLE, INTANGIBLE, HARD}
var phase

func _ready():
	phase = HARD
	Messenger.enemy_gets_jumped.connect(_enemy_gets_jumped.bind())

func got_jumped():
	match phase:
		HARD:
			Messenger.enemy_gets_jumped.emit("Enemy-Hard-Jumped-Once")
			collision_shape_2d.set_deferred("disabled", true)
			phase = INTANGIBLE
			anim.play("intangible")
		INTANGIBLE:
			pass
		TANGIBLE:
			Messenger.enemy_gets_jumped.emit("Enemy-Hard-Die")
			_die()

func _die():
	queue_free()

func _enemy_gets_jumped(_pass):
	if phase == INTANGIBLE:
		phase = TANGIBLE
		collision_shape_2d.set_deferred("disabled", false)
		anim.play("tangible")
