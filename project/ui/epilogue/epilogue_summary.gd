extends VBoxContainer

var epilogue : Epilogue

func _ready() -> void:
	assert(epilogue != null, "Epilogue must be set")
	
	if epilogue.gap_year:
		var label := Label.new()
		label.text = "Took a gap year"
		add_child(label)
	
	if epilogue.community_college:
		var label := Label.new()
		label.text = "Attended Community College"
		add_child(label)

	var college_label := Label.new()
	college_label.text = "Attended %s" % Epilogue.as_string(epilogue.college_type)
	add_child(college_label)

	for major in epilogue.majors:
		var label := Label.new()
		label.text = "Major: %s" % major.capitalize()
		add_child(label)
	
	for minor in epilogue.minors:
		var label := Label.new()
		label.text = "Minor: %s" % minor.capitalize()
		add_child(label)
