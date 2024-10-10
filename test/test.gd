extends Node2D

@onready var marker_above: Marker2D = $"marker above"
@onready var marker_below: Marker2D = $"marker below"
@onready var marker_player: Marker2D = $"marker player"
@onready var player: CharacterBody2D = $Player
@onready var marker_enemy: Marker2D = $"marker enemy"
@onready var enemy_chicken_3: Node2D = $Enemies/EnemyChicken3

func _ready():
	print("test global pos diff: ", marker_above.global_position.y - marker_below.global_position.y)
	print("marker vs player: ", marker_player.global_position.y - player.global_position.y)
	print("marker vs enemy top: ", marker_enemy.global_position.y - enemy_chicken_3.global_position.y)
