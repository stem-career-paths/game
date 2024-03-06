extends GutTest

func test_there_are_stories_enough_to_fill_a_playthrough() -> void:
	var story_loader := StoryLoader.new()
	var world := World.new()

	var story_paths := story_loader.get_starting_story_paths()
	var count := story_paths.size()

	var needed_stories := world.turns_per_year * 4

	assert_true(count >= needed_stories, "Not enough stories. We need at least %d but there are %d." % [
		needed_stories,
		count
	])
