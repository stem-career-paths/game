extends GutTest

const TEST_STORY_DIR := "res://test/unit/story_loader_test_stories/"

var story_loader: StoryLoader


func before_each() -> void:
	story_loader = StoryLoader.new()


func test_get_story_paths_in_directory() -> void:
	var path := TEST_STORY_DIR.path_join("all_gd")
	var story_paths = story_loader.get_story_paths_in_directory(path)
	assert_eq(story_paths.size(), 2)


func test_get_story_paths_in_directory_with_non_gd_files() -> void:
	var path := TEST_STORY_DIR.path_join("not_all_gd")
	var story_paths = story_loader.get_story_paths_in_directory(path)
	assert_eq(story_paths.size(), 2)


func test_get_story_paths_in_directory_with_no_stories() -> void:
	var path := TEST_STORY_DIR.path_join("no_stories")
	var story_paths = story_loader.get_story_paths_in_directory(path)
	assert_eq(story_paths.size(), 0)


func test_get_story_paths_in_directory_multi_level() -> void:
	var path := TEST_STORY_DIR.path_join("multi_level")
	var story_paths = story_loader.get_story_paths_in_directory(path)
	assert_eq(story_paths.size(), 8)


func test_get_story_paths_in_directory_with_invalid_directory() -> void:
	var path := TEST_STORY_DIR.path_join("invalid_directory")
	var story_paths = story_loader.get_story_paths_in_directory(path)
	assert_eq(story_paths.size(), 0)


func test_get_story_paths_with_ignore() -> void:
	var path := TEST_STORY_DIR
	var ignore: Array[String] = [ TEST_STORY_DIR.path_join("all_gd") ]

	var all_story_paths = story_loader.get_story_paths_in_directory(path)
	var ignore_story_paths = story_loader.get_story_paths_in_directory(path, ignore)

	assert_ne(all_story_paths.size(), ignore_story_paths.size())


func test_get_simple_story_paths_in_directory() -> void:
	var path := TEST_STORY_DIR.path_join("all_gd")
	var story_paths = story_loader.get_simple_story_paths_in_directory(path)
	assert_eq(story_paths.size(), 1)


func test_get_simple_story_paths_with_ignore() -> void:
	var path := TEST_STORY_DIR
	var ignore: Array[String] = [ TEST_STORY_DIR.path_join("all_gd") ]

	var all_story_paths = story_loader.get_simple_story_paths_in_directory(path)
	var ignore_story_paths = story_loader.get_simple_story_paths_in_directory(path, ignore)

	assert_ne(all_story_paths.size(), ignore_story_paths.size())


func test_load_simple_story_valid_story() -> void:
	var file_path := TEST_STORY_DIR.path_join("all_gd").path_join("test_story_1.gd")
	var story := story_loader.load_simple_story(file_path)

	assert_not_null(story)


func test_load_simple_story_invalid_story() -> void:
	var file_path := TEST_STORY_DIR.path_join("all_gd").path_join("test_story_2.gd")
	var story = story_loader.load_simple_story(file_path)

	assert_null(story)


func test_load_simple_story_non_gd_file() -> void:
	var file_path := TEST_STORY_DIR.path_join("not_all_gd").path_join("not_a_story.txt")
	var story = story_loader.load_simple_story(file_path)

	assert_null(story)


func test_load_simple_story_invalid_file_path() -> void:
	var file_path := TEST_STORY_DIR.path_join("invalid_directory").path_join("invalid_story.gd")
	var story = story_loader.load_simple_story(file_path)

	assert_null(story)


func test_load_simple_story_ignore_returns_null() -> void:
	var file_path := TEST_STORY_DIR.path_join("all_gd").path_join("test_story_1.gd")
	var ignore: Array[String] = [ TEST_STORY_DIR.path_join("all_gd") ]

	var story = story_loader.load_simple_story(file_path, ignore)

	assert_null(story)
