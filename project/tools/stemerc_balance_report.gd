## A tool script attached to a scene that shows the current distribution
## of available STEMERC options from all reachable stories.
##
@tool
extends Control

@export var regenerate_report := false:
	set(value):
		_generate_report()

var _calculator := DistributionCalculator.new()


func _generate_report() -> void:
	queue_redraw()


func _draw() -> void:
	var distribution := _calculator.calculate()
	var font := get_theme_default_font()
	var position := Vector2(0, get_theme_default_font_size())
	var text := ("STEMERC Distribution among SimpleStory scripts:\n%s\n\n" +
		"Toggle \"Regenerate Report\" to refresh.\nLast Generated %s") % [
		str(distribution),
		Time.get_datetime_string_from_system(),
	]
	draw_multiline_string(get_theme_default_font(), position, text)
