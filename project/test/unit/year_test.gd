extends GutTest


func test_not_year() -> void:
	assert_eq(Year.not_year(Year.Name.SOPHOMORE), 
		[ Year.Name.FRESHMAN, Year.Name.JUNIOR, Year.Name.SENIOR ])


func test_not_years() -> void:
	assert_eq(Year.not_years([Year.Name.FRESHMAN, Year.Name.SOPHOMORE]), 
		[ Year.Name.JUNIOR, Year.Name.SENIOR ])


func test_has_next(params=use_parameters([
	[Year.Name.FRESHMAN, true],
	[Year.Name.SOPHOMORE, true],
	[Year.Name.JUNIOR, true],
	[Year.Name.SENIOR, false]
])) -> void:
	var year :Year.Name= params[0]
	var expected :bool = params[1]
	assert_eq(Year.has_next(year), expected,
		"Expected year %s result to be %s" % [str(year), str(expected)]
	)


func test_next(params=use_parameters([
	[Year.Name.FRESHMAN, Year.Name.SOPHOMORE],
	[Year.Name.SOPHOMORE, Year.Name.JUNIOR],
	[Year.Name.JUNIOR, Year.Name.SENIOR]
])):
	var year :Year.Name = params[0]
	var next :Year.Name = params[1]
	assert_eq(Year.next(year), next, 
		"Year after %s should be %s" % [str(year), str(next)])
