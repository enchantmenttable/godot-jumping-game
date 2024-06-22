extends Area2D

@export_range(1, 4) var stage_id : int = 1
@export_enum("Open", "Closed") var state : String = "Closed"

@onready var anim = $AnimatedSprite2D
@onready var label = $Label

# TODO: get state from save file

func _ready():
	label.visible = false
	anim.play(state)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.visible = true
		if state == "Open":
			body.door_id = stage_id
			body.inside_door = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.visible = false
		if state == "Open":
			body.inside_door = false
