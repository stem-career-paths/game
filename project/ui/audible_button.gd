extends Button

@onready var _audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func play_varied_sound():
	_audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
	_audio_stream_player.play()


func _on_pressed():
	play_varied_sound()
