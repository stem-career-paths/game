class_name Year

enum Name {
	FRESHMAN,
	SOPHOMORE,
	JUNIOR,
	SENIOR
}

## Get the common English name of the academic year.
static func as_string(year:Name) -> String:
	match year:
		Name.FRESHMAN:
			return "Freshman"
		Name.SOPHOMORE:
			return "Sophomore"
		Name.JUNIOR:
			return "Junior"
		Name.SENIOR:
			return "Senior"
	push_error("Unmatched year: %s" % str(year))
	return "Impossible condition"


## Get the USA grade number of the academic year (e.g. "9th")
static func as_ordinal(year:Name) -> String:
	match year:
		Name.FRESHMAN:
			return "9th"
		Name.SOPHOMORE:
			return "10th"
		Name.JUNIOR:
			return "11th"
		Name.SENIOR:
			return "12th"
	push_error("Unmatched year: %s" % str(year))
	return "Impossible condition"


## Determine if the given year has a next year or if it is terminal.
static func has_next(year:Name) -> bool:
	return year!=Name.SENIOR


## Get the year that comes after the given year.
## If the year doesn't have a next year, this will push an error.
static func next(year:Name) -> Name:
	match year:
		Name.FRESHMAN: return Name.SOPHOMORE
		Name.SOPHOMORE: return Name.JUNIOR
		Name.JUNIOR: return Name.SENIOR
	push_error("Year does not have a next: %s" % str(year))
	# This is a meaningless return but is required for the interpreter
	# to see that all code paths return a value.
	return Name.FRESHMAN


## Return the array of all the years except the given one.
static func not_year(year:Name) -> Array[Name]:
	return values().filter(func(y): return y != year)


## Return all the years except the given ones.
static func not_years(years: Array[Name]) -> Array[Name]:
	return values().filter(func(y): return not years.has(y))


## Get all the possible Year values.
static func values() -> Array[Name]:
	return [
		Name.FRESHMAN,
		Name.SOPHOMORE,
		Name.JUNIOR,
		Name.SENIOR,
	]


static func is_underclass(year : Name) -> bool:
	return year == Name.FRESHMAN or year == Name.SOPHOMORE
