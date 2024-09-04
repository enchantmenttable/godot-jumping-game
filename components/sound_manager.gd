extends Node2D

@onready var bouncy_head_sound_timer = $BouncyHead/SoundPlaying
@onready var audio_stream_player_2d = $BouncyHead/AudioStreamPlayer2D
@onready var audio_stream_player_2d_2 = $BouncyHead/AudioStreamPlayer2D2
@onready var audio_stream_player_2d_3 = $BouncyHead/AudioStreamPlayer2D3
@onready var audio_stream_player_2d_4 = $BouncyHead/AudioStreamPlayer2D4
@onready var audio_stream_player_2d_5 = $BouncyHead/AudioStreamPlayer2D5
@onready var audio_stream_player_2d_6 = $BouncyHead/AudioStreamPlayer2D6
var bouncy_head_spring_sounds = []

func _ready():
	bouncy_head_spring_sounds = [
		audio_stream_player_2d,
		audio_stream_player_2d_2,
		audio_stream_player_2d_3,
		audio_stream_player_2d_4,
		audio_stream_player_2d_5,
		audio_stream_player_2d_6
	]
	Messenger.bouncy_head_got_jumped.connect(_bouncy_head_got_jumped)

var rng = RandomNumberGenerator.new()
var bouncy_head_sound_playing = false
func _bouncy_head_got_jumped():
	if not bouncy_head_sound_playing:
		bouncy_head_spring_sounds[rng.randi_range(0, 5)].play()
	bouncy_head_sound_playing = true
	bouncy_head_sound_timer.start()

func _on_sound_playing_timeout():
	bouncy_head_sound_playing = false
