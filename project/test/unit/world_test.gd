extends GutTest

const _NUMBER_OF_TEST_STORIES := 2

func test_add_stories() -> void:
	var world := World.new()
	var initial_story_count := world.available_stories.size()
	var dir := DirAccess.open("res://test/unit/test_stories")
	var added_paths := world.add_stories(dir)
	var expected := initial_story_count + _NUMBER_OF_TEST_STORIES
	assert_eq(world.available_stories.size(), expected)
	assert_eq(added_paths.size(), _NUMBER_OF_TEST_STORIES)
	assert_eq(added_paths[0], "res://test/unit/test_stories/test_story_1.gd")
	
