class_name Year

enum {
	Freshman,
	Sophomore,
	Junior,
	Senior,
}


static func values() -> Array[int]:
	return [Freshman, Sophomore, Junior, Senior]


static func keys() -> Array[String]:
	return ["Freshman", "Sophomore", "Junior", "Senior"]


static func not_in(years: Array[int]) -> Array[int]:
	return Year.values().filter(func(year: int): return not years.has(year))
