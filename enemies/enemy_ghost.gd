extends Enemy

@onready var collision_shape_2d = $Body/JumpOnPart/CollisionShape2D
@onready var enemy_path_2d: Path2D = $EnemyPath2D

func _ready():
	Messenger.all_tangible_enemies_dead.connect(_change_form)

func got_jumped():
	Messenger.enemy_gets_jumped.emit("Enemy-Ghost")
	_die()

func _change_form():
	collision_shape_2d.set_deferred("disabled", false)
	anim.play("tangible")

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "die":
		queue_free()
