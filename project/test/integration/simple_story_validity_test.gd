## Tests the structural validity of all of the SimpleStory subclasses
## that can be found in the story directories.
extends GutTest

const STORY_PATH := "res://story/"
const END_STORY_PATH := "res://end/"

const MAX_OPTIONS_PER_STORY := 4
const MAX_LINES_PER_STORY := 7
const MAX_LINES_PER_OPTION := 3

var story_paths: Array[String] = []


func before_all():
	story_paths = _get_story_paths_in_directory(STORY_PATH)


func test_stories_exist():
	assert_true(story_paths.size() > 0, "No stories found in %s" % STORY_PATH)


func test_story_has_text():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		assert_true("text" in story, "Story %s has text" % story_path)


func test_story_text_is_array_or_string():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		assert_true(story.text is Array or story.text is String, "Story %s text is an array or string" % story_path)


func test_story_text_string_has_content():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		_test_text_content(story.text, story_path)


func test_story_has_options():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		assert_true("options" in story, "Story %s has options" % story_path)


func test_story_options_is_dictionary():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		assert_true(story.options is Dictionary, "Story %s options is a dictionary" % story_path)


func test_story_has_at_least_one_option():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		assert_true(story.options.size() > 0, "Story %s has at least one option" % story_path)


func test_story_has_at_most_max_options():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		assert_true(story.options.size() <= MAX_OPTIONS_PER_STORY, "Story %s has at most %d options" % [story_path, MAX_OPTIONS_PER_STORY])


func test_all_story_options_are_dictionaries():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)

		for option in story.options.keys():
			assert_true(story.options[option] is Dictionary, "Story %s option %s is a dictionary" % [story_path, option])


func test_all_story_options_have_text():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)

		for option in story.options.keys():
			assert_true("text" in story.options[option], "Story %s option %s has text" % [story_path, option])


func test_all_story_options_text_is_array_or_string():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)

		for option in story.options.keys():
			assert_true(story.options[option].text is Array or story.options[option].text is String, "Story %s option %s text is an array or string" % [story_path, option])


func test_all_story_options_text_string_have_content():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)

		for option in story.options.keys():
			_test_text_content(story.options[option].text, story_path)


func test_all_story_options_have_at_least_one_line():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		var option_line_lengths := await _get_option_line_lengths(story)

		for option_line_length in option_line_lengths:
			assert_true(option_line_length > 0, "Story %s option has at least one line" % story_path)


func test_all_story_options_have_at_most_max_lines():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		var option_line_lengths := await _get_option_line_lengths(story)

		for option_line_length in option_line_lengths:
			assert_true(option_line_length <= MAX_LINES_PER_OPTION, "Story %s option has at most %d lines" % [story_path, MAX_LINES_PER_OPTION])


func test_story_options_have_at_most_max_lines_total():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)
		var option_line_lengths := await _get_option_line_lengths(story)
		var total_lines := 0

		for option_line_length in option_line_lengths:
			total_lines += option_line_length

		assert_true(total_lines <= MAX_LINES_PER_STORY, "Story %s has at most %d lines" % [story_path, MAX_LINES_PER_STORY])


func test_all_story_options_effects_is_dictionary():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)

		for option in story.options.keys():
			if "effects" in story.options[option]:
				assert_true(story.options[option].effects is Dictionary, "Story %s option %s effects is a dictionary" % [story_path, option])


func test_all_story_options_effects_keys_are_valid():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)

		for option in story.options.keys():
			if "effects" in story.options[option]:
				for effect in story.options[option].effects.keys():
					assert_true(effect in Character.ATTRIBUTE_NAMES, "Story %s option %s effect %s is a valid attribute" % [story_path, option, effect])


func test_all_story_options_end_story_exists():
	for story_path in story_paths:
		var story := _load_simple_story(story_path)

		for option in story.options.keys():
			if "end_story" in story.options[option]:
				var end_story_path := "%send_%s.gd" % [END_STORY_PATH, story.options[option].end_story]
				var end_story_resource := load(end_story_path)

				assert_not_null(end_story_resource, "Story %s option %s end_story exists" % [story_path, option])


func _get_story_paths_in_directory(path: String) -> Array[String]:
	var paths: Array[String] = []

	var dir := DirAccess.open(path)
	assert_not_null(dir, "Could not open directory " + path)

	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		var file_path := path + file_name
		if dir.current_is_dir():
			paths.append_array(_get_story_paths_in_directory(file_path + "/"))
		elif file_name.ends_with(".gd") and _is_path_simple_story(file_path):
			paths.append(file_path)

		file_name = dir.get_next()

	return paths


func _load_simple_story(file_path: String) -> SimpleStory:
	var resource := load(file_path)
	var story: Object = resource.new()

	return story


func _is_path_simple_story(file_path: String) -> bool:
	return _load_simple_story(file_path) is SimpleStory


func _test_text_content(text, story_path: String):
	if text is String:
		assert_false(text.strip_edges().is_empty(), "Story %s text has content" % [story_path])
	elif text is Array:
		for line in text:
			assert_false(line.strip_edges().is_empty(), "Story %s text has content in all lines" % [story_path])


func _get_option_line_lengths(story: SimpleStory) -> Array[int]:
	var game_screen: Node = add_child_autoqfree(preload("res://ui/game_screen.tscn").instantiate())

	for option in story.options:
		game_screen.create_option_button(option)

	# Required to let the UI "settle" before checking the line count.
	await get_tree().process_frame

	var option_buttons := game_screen.get_node("%OptionArea").get_children()

	var result: Array[int] = []

	for button in option_buttons:
		var label := button.get_node("%Label")
		var text_lines = label.get_visible_line_count()

		result.append(text_lines)

	return result
