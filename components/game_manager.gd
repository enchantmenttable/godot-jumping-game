extends Node2D

@export var final_level : bool = false
@export var next_level : PackedScene
var next_level_path : String

var enemy_count : int

func _ready():
	Messenger.enemy_gets_jumped.connect(_enemy_gets_jumped)
	Messenger.player_forbidden_touch.connect(_player_forbidden_touch)

	enemy_count = get_tree().get_nodes_in_group("Enemy").size()

	if not final_level:
		next_level_path = next_level.resource_path

func _process(_float): # testing purpose
	if Input.is_action_just_pressed("restart"):
		get_tree().call_deferred("reload_current_scene")
	if Input.is_action_just_pressed("quit_game"):
		get_tree().quit()

func _player_forbidden_touch():
	get_tree().call_deferred("reload_current_scene")

func _enemy_gets_jumped():
	enemy_count -= 1
	if enemy_count == 0:
		if not final_level:
			win()
		else:
			win_stage()

func win():
	get_tree().call_deferred("change_scene_to_file", next_level_path)

func win_stage():
	pass
