extends GutTest


const TEST_STORY_DIR := "res://test/unit/test_stories"
const NUMBER_OF_TEST_STORIES := 2

var world: World


func before_each() -> void:
	world = autofree(World.new())


func test_add_stories() -> void:
	var initial_story_count := world.available_stories.size()
	var added_paths := world.add_stories(TEST_STORY_DIR)
	var expected := initial_story_count + NUMBER_OF_TEST_STORIES
	assert_eq(world.available_stories.size(), expected)
	assert_eq(added_paths.size(), NUMBER_OF_TEST_STORIES)
	assert_eq(added_paths[0], "%s/test_story_1.gd" % TEST_STORY_DIR)


func test_remove_stories() -> void:
	var initial_story_count := world.available_stories.size()
	world.add_stories(TEST_STORY_DIR)
	var removed_paths := world.remove_stories(TEST_STORY_DIR)
	assert_eq(world.available_stories.size(), initial_story_count)
	assert_eq(removed_paths.size(), NUMBER_OF_TEST_STORIES)
	assert_eq(removed_paths[0], "%s/test_story_1.gd" % TEST_STORY_DIR)
