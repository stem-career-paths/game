extends GutTest

const _STORY_PATH := "res://story/"

## Test all the stories in _STORY_PATH and its subdirectories 
## that are SimpleStory subclasses.
func test_simple_stories_have_expected_structure():
	_test_directory(_STORY_PATH)


func _test_directory(path:String)->void:
	for file_name in DirAccess.get_files_at(path):
		var file_path := path + file_name
		var resource = load(file_path)
		var story :Object = resource.new()
		if story is SimpleStory:
			_test_structure_of(story)
	
	for subdir in DirAccess.get_directories_at(path):
		_test_directory("%s%s/" % [path, subdir])


func _test_structure_of(story:Object)->void:
	assert_true("text" in story, "Story must have a 'text' field")
	assert_false(story.text.strip_edges().is_empty(), "The 'text' field must have content")
	assert_true("options" in story, "Story must have an 'options' field")
	assert_true(typeof(story.options) == TYPE_DICTIONARY, "The 'options' field must be a dictionary")
	for key in story.options.keys():
		assert_true(typeof(story.options[key]) == TYPE_DICTIONARY, 
			"Each options entry should be a dictionary but %s is not" % key)
		_test_options(story.options[key])
	

func _test_options(options:Dictionary):
	assert_true("text" in options, "Each option needs a 'text' field.")
	if "effects" in options:
		assert_eq(typeof(options["effects"]), TYPE_DICTIONARY)
		var effects : Dictionary = options["effects"]
		for key in effects:
			assert_eq(typeof(key), TYPE_STRING)
			assert_true(key in Character.ATTRIBUTE_NAMES)
