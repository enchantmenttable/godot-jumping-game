extends Area2D

@export_range(0, 4) var stage_id : int = 1
@export_enum("Open", "Closed") var state : String = "Closed"

var player_inside = false

@onready var anim = $AnimatedSprite2D
@onready var level_select_panel_3x2 = $LevelSelectPanel3x2
@onready var stage_label = $StageLabel

func _ready():
	anim.play(state)
	level_select_panel_3x2.visible = false

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_inside = true
	#if body.is_in_group("Player"):
		#if state == "Open":
			#body.door_id = stage_id
			#body.inside_door = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_inside = false
		pass
		#if state == "Open":
			#body.inside_door = false

func _process(_float):
	if Input.is_action_pressed("up") and player_inside and level_select_panel_3x2.visible == false:
		level_select_panel_3x2.visible = true
		level_select_panel_3x2.selected()
		Messenger.player_selecting_level.emit()
		stage_label.visible = false
