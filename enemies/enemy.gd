extends Node2D
class_name Enemy

@onready var anim: AnimatedSprite2D = $Body/AnimatedSprite2D
@onready var path_2d: Path2D = $EnemyPath2D

func _die():
	anim.play("die")
	path_2d.speed = 0
