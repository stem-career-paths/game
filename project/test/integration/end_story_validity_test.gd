extends GutTest


const _END_STORY_PATH := "res://end/"


func test_end_stories_have_expected_structure():
	var tested_directories := _test_directory(_END_STORY_PATH)
	assert_true(tested_directories > 0, 
		"The test properly processed more than zero directories.")


## Returns the number of directories processed.
func _test_directory(path: String, accumulator := 0) -> int:
	var dir := DirAccess.open(path)
	assert_not_null(dir, "Directory exists: %s" % path)

	for file_name in DirAccess.get_files_at(path):
		var file_path := path + file_name
		var resource = load(file_path)
		var story: Object = resource.new()
		_test_structure_of(story)

	var directories := 1
	for subdir in DirAccess.get_directories_at(path):
		directories += _test_directory("%s%s/" % [path, subdir])

	return directories + accumulator


func _test_structure_of(story: Object) -> void:
	assert_true("text" in story, "Story must have a 'text' field")
	_test_text(story.text)


func _test_text(text: Variant):
	if typeof(text) == TYPE_STRING:
		assert_false(text.strip_edges().is_empty(), "The 'text' field must have content")
	elif typeof(text) == TYPE_ARRAY:
		for line in text:
			assert_false(line.strip_edges().is_empty(), "The 'text' field must have content in each line")
	else:
		assert_true(false, "The 'text' field must be an string or an array")
