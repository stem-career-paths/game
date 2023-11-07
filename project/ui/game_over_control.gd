extends VBoxContainer

var major: String:
	set(value):
		text = value
		%Major.text = value

var text: String:
	set(value):
		text = value
		%Label.text = value
