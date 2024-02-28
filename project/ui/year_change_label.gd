extends Label

var year : Year.Name:
	set(value):
		year = value
		text = "%s Year!" % Year.as_string(year)
