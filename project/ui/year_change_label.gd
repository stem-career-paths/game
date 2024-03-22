extends Label

var year : Year.Name:
	set(value):
		year = value
		text = "%s Grade:\n%s Year!" % [Year.as_ordinal(year), Year.as_string(year)]
