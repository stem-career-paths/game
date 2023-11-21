extends HBoxContainer

@export var marker := "*"

var world: World:
	set(value):
		if world != null:
			if world != value:
				world.turns_changed.disconnect(_update_display)
		
		world = value
		value.turns_changed.connect(_update_display)
		_update_display(value.turns)

@onready var _year_name: Label = %YearName
@onready var _year_progress: Label = %YearProgress


func _lookup_year_name(percent_complete: float) -> String:
	if percent_complete < 0.25:
		return "Freshman"
	elif percent_complete < 0.5:
		return "Sophomore"
	elif percent_complete < 0.75:
		return "Junior"
	else:
		return "Senior"


func _lookup_year_progress(turn: int, turns_per_year: int) -> String:
	var year_progress := turn % turns_per_year
	var markers := []

	for i in range(year_progress + 1):
		markers.append(marker)

	return " ".join(markers)


func _update_display(turns: int) -> void:
	var percent_complete: float = turns / (world.turns_per_year * 4.0)
	_year_name.text = _lookup_year_name(percent_complete)
	_year_progress.text = _lookup_year_progress(turns, world.turns_per_year)
