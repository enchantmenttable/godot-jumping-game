extends Enemy

@onready var switch_side_timer = $Body/AnimatedSprite2D/SwitchSide
@onready var enemy_path_2d = $EnemyPath2D
@export var carrying_key = false

func _ready():
	if enemy_path_2d.get_curve().point_count == 0:
		anim.play("idle")
	else:
		anim.play("moving")

func _process(_float):
	pass

func got_jumped():
	Messenger.enemy_gets_jumped.emit("Enemy-Normal")
	if carrying_key:
		Messenger.key_acquired.emit(0)
	_die()

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "die":
		queue_free()
