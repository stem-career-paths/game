class_name StoryLoader
extends RefCounted

const STORY_PATH := "res://story/"
const STARTING_STORIES_PATH := STORY_PATH + "starting_stories/"


## Get all story paths in the starting stories directory
func get_starting_story_paths() -> Array[String]:
	return get_story_paths_in_directory(STARTING_STORIES_PATH)


## Get all simple story paths in the starting stories directory
func get_starting_simple_story_paths() -> Array[String]:
	return get_simple_story_paths_in_directory(STARTING_STORIES_PATH)


## Get all story paths in a directory
func get_story_paths_in_directory(path: String) -> Array[String]:
	var paths: Array[String] = []

	var dir := DirAccess.open(path)
	if not dir:
		return paths

	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		var file_path := path.path_join(file_name)

		if dir.current_is_dir():
			paths.append_array(get_story_paths_in_directory(file_path))
		elif _is_valid_story_path(file_path):
			paths.append(file_path)

		file_name = dir.get_next()

	return paths


## Get all simple story paths in a directory
func get_simple_story_paths_in_directory(path: String) -> Array[String]:
	return get_story_paths_in_directory(path).filter(
		func(story_path: String) -> bool: return load_simple_story(story_path) != null
	)


## Load a simple story from a file path
func load_simple_story(file_path: String) -> SimpleStory:
	if not _is_valid_story_path(file_path):
		return null

	var resource := load(file_path)
	var story: Object = resource.new()

	if not story is SimpleStory:
		return null

	return story


func _is_valid_story_path(path: String) -> bool:
	return path.ends_with(".gd") and FileAccess.file_exists(path)
