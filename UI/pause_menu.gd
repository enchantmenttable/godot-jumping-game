extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not get_tree().paused:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false

func _on_continue_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_level_select_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/stage_select.tscn")
