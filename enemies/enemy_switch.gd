extends Node2D

@onready var anim = $Body/AnimatedSprite2D
@onready var switch_side_timer = $Body/AnimatedSprite2D/SwitchSide
@onready var enemy_path_2d = $EnemyPath2D
@onready var jump_part_collider = $Body/JumpOnPart/CollisionShape2D

@export_enum("Open", "Closed") var current_phase : String = "Open"

func _ready():
	Messenger.enemy_gets_jumped.connect(_enemy_gets_jumped.bind())
	_switch_phase(current_phase)


func _enemy_gets_jumped(_pass):
	match current_phase:
		"Open":
			_switch_phase("Closed")
		"Closed":
			_switch_phase("Open")


func _switch_phase(to_phase):
	current_phase = to_phase
	match to_phase:
		"Open":
			anim.play(to_phase)
			jump_part_collider.set_deferred("disabled", false)
		"Closed":
			anim.play(to_phase)
			jump_part_collider.set_deferred("disabled", true)

func got_jumped():
	match current_phase:
		"Closed":
			pass
		"Open":
			Messenger.enemy_gets_jumped.emit("Enemy-Switch-Die")
			_die()

func _die():
	enemy_path_2d.speed = 0
	anim.play("die")


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "die":
		queue_free()
