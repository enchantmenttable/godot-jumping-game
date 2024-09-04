extends Node2D


@onready var collision_shape_2d = $Body/JumpOnPart/CollisionShape2D
@onready var anim = $Body/AnimatedSprite2D


func _ready():
	Messenger.all_tangible_enemies_dead.connect(_change_form)

func got_jumped():
	Messenger.enemy_gets_jumped.emit("Enemy-Ghost")
	_die()

func _change_form():
	collision_shape_2d.set_deferred("disabled", false)
	anim.play("tangible")

func _die():
	queue_free()
