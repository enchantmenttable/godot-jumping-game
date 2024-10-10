extends Node2D

@export var final_level : bool = false
@export var final_stage : bool = false
@export var next_level : PackedScene
@export var global_level_id : int
var next_level_path : String

@export_range(1, 4) var stage_id : int

var enemy_count : int
var ghost_count : int

@onready var pause_menu: CanvasLayer = $PauseMenu

var pitch_scale = 0
@onready var enemy_got_jumped_neg_40 = $"SoundHolder/EnemyGotJumped-neg40"
@onready var enemy_got_jumped_neg_30 = $"SoundHolder/EnemyGotJumped-neg30"
@onready var enemy_got_jumped_neg_20 = $"SoundHolder/EnemyGotJumped-neg20"
@onready var enemy_got_jumped_neg_10 = $"SoundHolder/EnemyGotJumped-neg10"
@onready var enemy_got_jumped = $SoundHolder/EnemyGotJumped
@onready var enemy_got_jumped_pos_10 = $"SoundHolder/EnemyGotJumped-pos10"
@onready var enemy_got_jumped_pos_20 = $"SoundHolder/EnemyGotJumped-pos20"
@onready var enemy_got_jumped_pos_30 = $"SoundHolder/EnemyGotJumped-pos30"
var got_jumped_sounds = []

@onready var win_level_sound = $SoundHolder/WinLevel
@onready var win_stage_sound = $SoundHolder/WinStage
@onready var die_sound = $SoundHolder/Die

var stage_select_path = "res://levels/stage_select.tscn"
var enemy_normal_count = 0
var enemy_ghost_count = 0
var enemy_hard_count = 0
var enemy_switch_count = 0
var total_enemy_count = 0

func _ready():
	pause_menu.hide()

	Messenger.enemy_gets_jumped.connect(_enemy_gets_jumped.bind())
	Messenger.player_forbidden_touch.connect(_player_forbidden_touch)

	_count_enemies()

	if not final_level:
		next_level_path = next_level.resource_path

	got_jumped_sounds = [
		enemy_got_jumped_neg_40,
		enemy_got_jumped_neg_30,
		enemy_got_jumped_neg_20,
		enemy_got_jumped_neg_10,
		enemy_got_jumped,
		enemy_got_jumped_pos_10,
		enemy_got_jumped_pos_20,
		enemy_got_jumped_pos_30
	]

func _count_enemies():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies:
		if enemy.is_in_group("Enemy-Normal"):
			enemy_normal_count += 1
		elif enemy.is_in_group("Enemy-Ghost"):
			enemy_ghost_count += 1
		elif enemy.is_in_group("Enemy-Hard"):
			enemy_hard_count += 1
		elif enemy.is_in_group("Enemy-Switch"):
			enemy_switch_count += 1
	total_enemy_count = enemies.size()

func _process(_float): # testing purpose
	if Input.is_action_just_pressed("restart"):
		get_tree().call_deferred("reload_current_scene")

var forbidden_touch_triggered = 0
func _player_forbidden_touch():
	forbidden_touch_triggered += 1
	if forbidden_touch_triggered < 2:
		die_sound.play()

func _enemy_gets_jumped(enemy_type):
	match enemy_type:
		"Enemy-Normal":
			enemy_normal_count -= 1
		"Enemy-Hard-Die":
			enemy_hard_count -= 1

	if enemy_normal_count == 0 \
		and enemy_hard_count == 0 \
		and enemy_switch_count == 0:
		Messenger.all_tangible_enemies_dead.emit()

	got_jumped_sounds[pitch_scale].play()

	if enemy_type != "Enemy-Hard-Jumped-Once":
		pitch_scale += 1
		total_enemy_count -= 1

	if total_enemy_count == 0:
		save_progress()
		if not final_level:
			_win_level()
		else:
			_win_stage()


func _win_level():
	Messenger.player_change_to_win_state.emit()
	win_level_sound.play()

func _win_stage():
	Messenger.player_change_to_win_state.emit()
	Messenger.win_stage.emit(stage_id)
	win_stage_sound.play()

func _on_win_level_finished():
	get_tree().call_deferred("change_scene_to_file", next_level_path)

func _on_win_stage_finished():
	get_tree().call_deferred("change_scene_to_file", stage_select_path)

func _on_die_finished():
	get_tree().call_deferred("reload_current_scene")

func save_progress():
	var data = SaveData.new().load_data()
	data.current_progress += 1
	if final_level and final_stage:
		data.won = true
	data.save_data()
