## Tests the structural validity of all of the SimpleStory subclasses
## that can be found in the story directories.
extends GutTest

const CAST_PATH := "res://cast/"

const MAX_OPTIONS_PER_STORY := 4
const MAX_LINES_PER_STORY := 7
const MAX_LINES_PER_OPTION := 3
const MAX_EFFECTS := 2

var story_loader: StoryLoader
var story_paths: Array[String] = []

func before_all():
	story_loader = StoryLoader.new()
	story_paths = story_loader.get_story_paths_in_directory(StoryLoader.STORY_PATH)


func test_stories_exist():
	assert_true(story_paths.size() > 0, "No stories found in %s" % StoryLoader.STORY_PATH)


func test_story_has_npc():
	_for_each_story(func(story,path):
		assert_true("npc_name" in story, "Story %s has an npc" % path)
	)


func test_npc_is_in_cast():
	var cast := Cast.new()
	cast.load_cast(CAST_PATH)

	_for_each_story(func(story, path):
		var npc_name : String = story.npc_name
		assert_true(cast.contains(npc_name), 
			"Cast does not contain an NPC named '%s' in %s" % [story,path])
	)


func _for_each_story(callable:Callable) -> void:
	for story_path in story_paths:
		var story := story_loader.load_simple_story(story_path)

		# Skip the story if not a SimpleStory
		if not story:
			continue

		await callable.call(story, story_path)


func test_story_text_validity():
	_for_each_story(func(story, path):
		assert_true("text" in story, "Story %s has text" % path)
		assert_true(story.text is Array or story.text is String, "Story %s text is an array or string" % path)
		_assert_text_has_content(story.text, path)
	)


## Check that the given text is either a nonempty string
## or an array of nonempty strings.
func _assert_text_has_content(text, story_path: String):
	if text is String:
		assert_false(text.strip_edges().is_empty(), "Story %s text has content" % [story_path])
	elif text is Array:
		for line in text:
			assert_false(line.strip_edges().is_empty(), "Story %s text has content in all lines" % [story_path])


func test_story_has_options():
	_for_each_story(func(story,path):
		assert_true("options" in story, "Story %s has options" % path)
	)


func test_story_options_is_dictionary():
	_for_each_story(func(story,path):
		assert_true(story.options is Dictionary, "Story %s options is a dictionary" % path)
	)


func test_story_number_of_options():
	_for_each_story(func(story,path):
		var number_of_options : int = story.options.size()
		assert_true(number_of_options > 0, "Story %s has at least one option" % path)
		assert_true(number_of_options <= MAX_OPTIONS_PER_STORY, "Story %s has at most %d options" % [path, MAX_OPTIONS_PER_STORY])
	)


func test_all_story_options_are_dictionaries():
	_for_each_story(func(story,path):
		for option in story.options.keys():
			assert_true(story.options[option] is Dictionary, "Story %s option %s is a dictionary" % [path, option])
	)


func test_all_story_options_have_text():
	_for_each_story(func(story,path):
		for option in story.options.keys():
			assert_true("text" in story.options[option], 
				"Story %s option %s has text" % [path, option])
	)


func test_all_story_options_text_is_array_or_string():
	_for_each_story(func(story,path):
		for option in story.options.keys():
			var type = typeof(story.options[option].text)
			assert_true(type==TYPE_ARRAY or type==TYPE_STRING, 
				"Story %s option %s text is an array or string" % [path, option])
	)


func test_all_story_options_text_string_have_content():
	_for_each_story(func(story,path): 
		for option in story.options.keys():
			_assert_text_has_content(story.options[option].text, path)
	)


func test_all_story_options_number_of_lines():
	# The 'await' here is needed since the UI integration tests are
	# asynchronous. Without it, gut reports that no tests were run.
	await _for_each_story(func(story,path):
		var option_line_lengths := await _get_option_line_lengths(story)

		for option_line_length in option_line_lengths:
			assert_true(option_line_length > 0, 
				"Story %s option has at least one line" % path)
			assert_true(option_line_length <= MAX_LINES_PER_OPTION, 
				"Story %s option has at most %d lines" % [path, MAX_LINES_PER_OPTION])
		
		var total_lines : int = option_line_lengths.reduce(_sum, 0)
		assert_true(total_lines <= MAX_LINES_PER_STORY, 
			"Story %s has at most %d lines" % [path, MAX_LINES_PER_STORY])
	)


## Count the number of lines in each option of a story.
func _get_option_line_lengths(story: SimpleStory) -> Array[int]:
	var game_screen: Node = add_child_autofree(preload("res://ui/game_screen.tscn").instantiate())

	# Extract just the option names from the options dictionary
	var options :Array = story.options.keys()
	
	game_screen.show_options(options)

	# Required to let the UI "settle" before checking the line count.
	await get_tree().process_frame

	return game_screen.get_visible_line_counts_in_options()


func _sum(a:int, b:int) -> int:
	return a + b


func test_story_option_effect_validity():
	_for_each_story(func(story,path):
		for option in story.options.keys():
			if "effects" in story.options[option]:
				# The effects has to be a dictionary.
				assert_true(story.options[option].effects is Dictionary, 
					"Story %s option %s effects is a dictionary" % [path, option])
				
				# Each effect key must be an attribute name
				for effect in story.options[option].effects.keys():
					assert_true(effect in Character.ATTRIBUTE_NAMES, 
						"Story %s option %s effect %s is a valid attribute" % [path, option, effect])
	)


func test_all_story_year_constraints():
	_for_each_story(func(story,path):
		if "years" in story:
			assert_true(story.years is Array, "Story %s years is an array" % path)
			for year in story.years:
				assert_true(year is int, 
					"Story %s year %s is an integer" % [path, year])
				assert_true(Year.values().has(year), 
					"Story %s year %s is a valid year" % [path, year])
	)


# The UI is not robust to supporting three outcomes on a story,
# so we will make sure none have that many.
func test_stories_have_no_more_than_two_outcomes():
	_for_each_story(func(story,_path):
		for option in story.options.keys():
			if "effects" in story.options[option]:
				var count :int = story.options[option].effects.size()
				assert_lt(count, MAX_EFFECTS+1,
					"Option %s has %d but should have %d or less" %
						[option, count, MAX_EFFECTS])
	)


func test_location_validity():
	var game_map :GameMap = autofree(GameMap.new())
	_for_each_story(func(story,path): 
		if "location" in story:
			var location :String = story["location"]
			
			assert_eq(location.to_lower(), location, 
				"Location %s in story %s is not lowercase" % [location, path])
			assert_true(game_map.has_location(location), 
				"Location %s is in the map" % location)
		
		# If no stories have locations, then GUT throws a warning about how
		# this test included no asserts.
		# This kludge prevents that warning.
		else:
			assert_true(true)
	)
