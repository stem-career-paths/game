extends Node

func play_click_sound():
	$ClickSound.pitch_scale = randfn(1.0, 0.08)
	$ClickSound.play()
