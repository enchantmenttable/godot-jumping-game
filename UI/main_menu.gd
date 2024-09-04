extends CanvasLayer

@onready var start = $Control/VBoxContainer/VBoxContainer/HBoxContainer2/Start

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/stage_select.tscn")

func _ready():
	pass

func _init_save_data():
	var data_control = SaveData.new()
	if data_control.load_data() == null:
		data_control.save_data()
