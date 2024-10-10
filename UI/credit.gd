extends CanvasLayer

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://UI/main_menu.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
