extends Resource
class_name SaveData

@export var current_progress : int = 1

const SAVE_FILE_PATH = "user://save.tres"

func save_data():
	ResourceSaver.save(self, SAVE_FILE_PATH)

func load_data():
	if ResourceLoader.exists(SAVE_FILE_PATH):
		return load(SAVE_FILE_PATH)
	else:
		return null
