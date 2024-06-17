extends CanvasLayer

@onready var start_button = $Control/VBoxContainer/HBoxContainer/Start
@export var starting_level : PackedScene
var starting_level_path

func _ready():
	starting_level_path = starting_level.resource_path

func _on_start_pressed():
	get_tree().change_scene_to_file(starting_level_path)
