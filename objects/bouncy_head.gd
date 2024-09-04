extends Node2D

@onready var collision_shape_2d = $Body/JumpOnPart/CollisionShape2D
@onready var anim = $Body/AnimatedSprite2D
@onready var anim_timer = $AnimTimer

#@onready var audio_stream_player_2d = $Sounds/AudioStreamPlayer2D
#@onready var audio_stream_player_2d_2 = $Sounds/AudioStreamPlayer2D2
#@onready var audio_stream_player_2d_3 = $Sounds/AudioStreamPlayer2D3
#@onready var audio_stream_player_2d_4 = $Sounds/AudioStreamPlayer2D4
#@onready var audio_stream_player_2d_5 = $Sounds/AudioStreamPlayer2D5
#@onready var audio_stream_player_2d_6 = $Sounds/AudioStreamPlayer2D6
#var spring_sounds = []

#var rng = RandomNumberGenerator.new()

#func _ready():
	#spring_sounds = [
		#audio_stream_player_2d,
		#audio_stream_player_2d_2,
		#audio_stream_player_2d_3,
		#audio_stream_player_2d_4,
		#audio_stream_player_2d_5,
		#audio_stream_player_2d_6
	#]


func got_jumped():
	anim.play("got_jumped")
	Messenger.bouncy_head_got_jumped.emit()
	#spring_sounds[rng.randi_range(0, 5)].play()
	anim_timer.start()

func _on_anim_timer_timeout():
	anim.play("normal")
