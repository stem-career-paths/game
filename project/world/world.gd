## The state of the game world
class_name World extends RefCounted

const DEFAULT_TURNS_PER_YEAR := 3

## The current character whose story is being played
var character := Character.new()

## The stories that are available to draw from when a new one is needed
##
## The values are resource paths.
var available_stories: Array[String] = []

## The end stories that have been added to the world
var end_stories: Array[String] = []

## The cast of characters as a map from name to npc object
var cast := Cast.new()

## All the locations
var game_map := GameMap.new()

var turns_per_year := DEFAULT_TURNS_PER_YEAR

var year := Year.Name.FRESHMAN

## The number of turns the player has taken this year.
var _turns_this_year := 0


## Add all the stories in the given directory to the list
## of available stories
##
## Returns an array of the stories (resource paths) that were added
func add_stories(dir:DirAccess) -> Array[String]:
	var results : Array[String] = []
	for file_name in dir.get_files():
		var file_path := dir.get_current_dir() + "/" + file_name
		if FileAccess.file_exists(file_path):
			results.append(file_path)
			available_stories.append(file_path)
		else:
			push_error("Tried to append non-existing story path: %s" % file_path)
	return results


## Mark the end of the current turn.
##
## The result is true if the year changed and false otherwise.
## Finishing senior year does not count as the year changing.
func end_turn() -> bool:
	_turns_this_year += 1

	if _turns_this_year >= turns_per_year:
		_turns_this_year = 0
		if Year.has_next(year):
			year = Year.next(year)
			return true
	return false


## Remove all the stories in the given directory from the list
## of available stories
##
## Returns an array of the stories (resource paths) that were removed
func remove_stories(dir:DirAccess) -> Array[String]:
	var results : Array[String] = []
	for file_name in dir.get_files():
		var file_path := dir.get_current_dir() + "/" + file_name
		if FileAccess.file_exists(file_path):
			results.append(file_path)
			available_stories.erase(file_path)
		else:
			push_error("Tried to remove non-existing story path: %s" % file_path)
	return results


func get_active_stories() -> Array[String]:
	return available_stories.filter(func(story_path: String) -> bool:
		var story = (load(story_path) as RefCounted).new()

		if not "is_active" in story:
			return true

		return story.is_active(self)
	)
