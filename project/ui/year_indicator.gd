extends HBoxContainer

var world: World:
	set(value):
		if world != null:
			if world != value:
				world.years_changed.disconnect(_update_display)

		world = value
		world.years_changed.connect(_update_display)
		_update_display(world.years)

@onready var _year_name: Label = %YearName
@onready var _year_circles : Array[ProgressCircle] = [%Year1, %Year2, %Year3, %Year4 ]


func _update_display(years: int) -> void:
	_year_circles[years].year_passed = true
	_year_name.text = Year.keys()[years]
