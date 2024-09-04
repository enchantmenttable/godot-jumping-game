extends TextureButton

@export var local_level : int = 0
@export_enum("Completed", "In Progress", "Locked") var state : String = "Locked"

var stage : int
#var global_level : int

var texture_path = {
	"Locked": {
		"Normal" : "res://assets/UI/level_node_locked.png",
		"Focused": "res://assets/UI/focus_level_node_locked.png"
	},
	"In Progress": {
		"Normal" : "res://assets/UI/level_node_in_progress.png",
		"Focused": "res://assets/UI/focus_level_node_in_progress.png"
	},
	"Completed": {
		"Normal" : "res://assets/UI/level_node_completed.png",
		"Focused": "res://assets/UI/focus_level_node_complete.png"
	}
}

#func _ready():
	#texture_normal = load(texture_path[state]["Normal"])
	#texture_focused = load(texture_path[state]["Focused"])

func load_icon():
	texture_normal = load(texture_path[state]["Normal"])
	texture_focused = load(texture_path[state]["Focused"])


func _on_button_down():
	if state != "Locked":
		Messenger.player_chose_level.emit(stage, local_level)
