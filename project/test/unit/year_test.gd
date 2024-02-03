extends GutTest


func test_year_not_in_single() -> void:
	var years: Array[int] = [ Year.Freshman ]

	assert_eq(Year.not_in(years), [ Year.Sophomore, Year.Junior, Year.Senior ])


func test_year_not_in_multiple() -> void:
	var years: Array[int] = [ Year.Sophomore, Year.Senior ]

	assert_eq(Year.not_in(years), [ Year.Freshman, Year.Junior ])


func test_year_not_in_all() -> void:
	var years: Array[int] = [ Year.Freshman, Year.Sophomore, Year.Junior, Year.Senior ]

	assert_eq(Year.not_in(years), [])
