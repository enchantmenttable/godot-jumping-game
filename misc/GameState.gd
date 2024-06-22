extends Node

var unlocked_stages = []

func _ready():
	await Messenger.ready
	Messenger.win_stage.connect(_win_stage.bind())

func _win_stage(stage_id):
	if not unlocked_stages.has(stage_id):
		unlocked_stages.append(stage_id)

func _write_save_data():
	pass
