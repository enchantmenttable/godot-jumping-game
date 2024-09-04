extends Area2D

@onready var label = $Label
var player_inside = false

func _ready():
	label.visible = false


func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.visible = true
		player_inside = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.visible = false
		player_inside = false

func _process(_float):
	if Input.is_action_just_pressed("up") and player_inside:
		Messenger.player_chose_menu.emit()
