extends CanvasLayer

@onready var start = $Control/VBoxContainer/VBoxContainer/HBoxContainer2/Start

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/stage_select.tscn")

func _ready():
	_init_save_data()

func _init_save_data():
	var data_control = SaveData.new()
	if data_control.load_data() == null:
		data_control.save_data()


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/credit.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _clear_save():
	var data_control = SaveData.new()
	data_control.save_data()


func _on_clear_save_pressed() -> void:
	_clear_save()
