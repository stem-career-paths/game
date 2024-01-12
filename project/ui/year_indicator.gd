extends HBoxContainer

var world: World:
	set(value):
		if world != null:
			if world != value:
				world.turns_changed.disconnect(_update_display)
		
		world = value
		world.turns_changed.connect(_update_display)
		_update_display(world.turns)

@onready var _year_name: Label = %YearName
@onready var _year_circles : Array[ProgressCircle] = [%Year1, %Year2, %Year3, %Year4 ]


func _lookup_year_name(percent_complete: float) -> String:
	if percent_complete < 0.25:
		_year_circles[0].year_passed = true
		return "Freshman"
	elif percent_complete < 0.5:
		_year_circles[1].year_passed = true
		return "Sophomore"
	elif percent_complete < 0.75:
		_year_circles[2].year_passed = true
		return "Junior"
	else:
		_year_circles[3].year_passed = true
		return "Senior"


func _update_display(turns: int) -> void:
	var percent_complete: float = turns / (world.turns_per_year * 4.0)
	_year_name.text = _lookup_year_name(percent_complete)
