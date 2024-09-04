extends Node2D

@export var stage : int = 0

@onready var level_node_1 = $Panel/VBoxContainer/HBoxContainer/LevelNode1
@onready var level_node_2 = $Panel/VBoxContainer/HBoxContainer/LevelNode2
@onready var level_node_3 = $Panel/VBoxContainer/HBoxContainer/LevelNode3
@onready var level_node_4 = $Panel/VBoxContainer/HBoxContainer2/LevelNode4
@onready var level_node_5 = $Panel/VBoxContainer/HBoxContainer2/LevelNode5
@onready var level_node_6 = $Panel/VBoxContainer/HBoxContainer2/LevelNode6
var level_nodes = []

@onready var stage_door = get_owner()

var current_progress

func _ready():
	level_nodes = [
		level_node_1,
		level_node_2,
		level_node_3,
		level_node_4,
		level_node_5,
		level_node_6
	]

	current_progress = SaveData.new().load_data().current_progress
	print(current_progress)
	_level_nodes_setup()

func _level_nodes_setup():
	for level_node in level_nodes:
		level_node.stage = stage
		var global_level = level_node.local_level + (stage - 1) * 6
		if global_level > current_progress:
			level_node.state = "Locked"
		elif global_level == current_progress:
			level_node.state = "In Progress"
		else:
			level_node.state = "Completed"
		level_node.load_icon()

func selected():
	level_node_1.grab_focus()
	for level_node in level_nodes:
		if level_node.state == "In Progress":
			level_node.grab_focus()

func _on_close_panel_button_down():
	visible = false
	stage_door.stage_label.visible = true
	Messenger.player_stop_selecting_level.emit()
