extends VBoxContainer

var epilogue : Epilogue

func _ready() -> void:
	assert(epilogue != null, "Epilogue must be set")
	
	if epilogue.gap_year:
		var label := _make_summary_label()
		label.text = "Took a gap year"
		label.type = SummaryItem.Type.TIME
		_add_summary_item(label)
	
	if epilogue.community_college:
		var label := _make_summary_label()
		label.text = "Attended Community College"
		label.type = SummaryItem.Type.INSTITUTION
		_add_summary_item(label)

	var college_label := _make_summary_label()
	college_label.text = "Attended %s" % Epilogue.as_string(epilogue.college_type)
	college_label.type = SummaryItem.Type.INSTITUTION
	_add_summary_item(college_label)

	for major in epilogue.majors:
		var label := _make_summary_label()
		label.text = "Major: %s" % major.capitalize()
		label.type = SummaryItem.Type.DEGREE
		_add_summary_item(label)
	
	for minor in epilogue.minors:
		var label := _make_summary_label()
		label.text = "Minor: %s" % minor.capitalize()
		label.type = SummaryItem.Type.DEGREE
		_add_summary_item(label)


func _add_summary_item(item : Control) -> void:
	%SummaryItemsBox.add_child(item)

func _make_summary_label() -> Control:
	return preload("res://ui/epilogue/summary_item.tscn").instantiate()
