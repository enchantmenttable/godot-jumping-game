extends Node2D

@onready var thanks_label: Label = $thanks

var stage_addresses = {
	1: "res://levels/stage 1/level_1_1.tscn",
	2: "res://levels/stage 2/level_2_1.tscn",
	3: "res://levels/stage 3/level_3_1.tscn",
	4: "res://levels/stage 4/level_4_1.tscn"
}

# "res://levels/stage {stage}/level_{stage}_{level}.tscn".format({stage: stage, level: level})

var main_menu_address = "res://UI/main_menu.tscn"

func _ready():
	_display_thanks_banner()
	Messenger.player_chose_menu.connect(_load_menu)
	Messenger.player_chose_level.connect(_load_level.bind())

func _load_level(stage, level):
	get_tree().call_deferred("change_scene_to_file", "res://levels/stage {stage}/level_{stage}_{level}.tscn".format({"stage": stage, "level": level}) )

func _load_menu():
	get_tree().call_deferred("change_scene_to_file", main_menu_address)

func _display_thanks_banner():
	var data = SaveData.new().load_data()
	if data.won and not data.banner_shown_once:
		thanks_label.show()
		data.banner_shown_once = true
		data.save_data()
	else:
		thanks_label.hide()
