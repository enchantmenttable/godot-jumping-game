extends Node2D


var stage_addresses = {
	1: "res://levels/stage 1/level_1_1.tscn",
	2: "res://levels/stage 2/level_2_1.tscn",
	3: "res://levels/stage 2/level_3_1.tscn"
}

# "res://levels/stage {stage}/level_{stage}_{level}.tscn".format({stage: stage, level: level})

var main_menu_address = "res://UI/main_menu.tscn"

func _ready():
	Messenger.player_chose_menu.connect(_load_menu)
	Messenger.player_chose_level.connect(_load_level.bind())

func _load_level(stage, level):
	get_tree().call_deferred("change_scene_to_file", "res://levels/stage {stage}/level_{stage}_{level}.tscn".format({"stage": stage, "level": level}) )

func _load_menu():
	get_tree().call_deferred("change_scene_to_file", main_menu_address)
