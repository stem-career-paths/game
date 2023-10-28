@tool extends Control

signal pressed

@export var text : String:
	set(value):
		text = value
		$Label.text = value


@export var disabled := false:
	set(value):
		disabled = value
		$Button.disabled = disabled
		if disabled:
			var text_color :Color = $Button.get_theme_color("font_disabled_color")
			$Label.add_theme_color_override("font_color", text_color)


func _on_pressed():
	Sfx.play_click_sound()
	pressed.emit()
