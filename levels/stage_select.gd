extends Node2D

# TODO: level select

var stage_addresses = {
	1: "res://levels/stage 1/level_1_1.tscn",
	2: "res://levels/stage 2/level_2_1.tscn"
}

func _ready():
	Messenger.player_chose_state.connect(_load_stage.bind())

func _load_stage(stage_id):
	get_tree().call_deferred("change_scene_to_file", stage_addresses[stage_id])
