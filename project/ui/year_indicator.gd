extends HBoxContainer

@onready var _year_name := %YearName
@onready var _year_circles := {
	Year.Name.FRESHMAN: %Year1,
	Year.Name.SOPHOMORE: %Year2,
	Year.Name.JUNIOR: %Year3,
	Year.Name.SENIOR: %Year4,
}

func switch_to_text(text:String) -> void:
	%YearName.text = text
	$YearProgressContainer.visible = false


## Set the year programatically and instantly
func set_year(year:Year.Name) -> void:
	_year_circles[year].year_passed = true
	_year_name.text = Year.as_string(year)


## Update this widget to show the given year
func show_advancement(new_year:Year.Name) -> void:
	_year_circles[new_year].year_passed = true
	_year_name.text = Year.as_string(new_year)
