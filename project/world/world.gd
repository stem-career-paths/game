## The state of the game world
class_name World extends RefCounted

signal turns_changed(new_turn : int)

## The maximum number of turns that can be taken in a year
const MAX_TURNS_PER_YEAR = 3

## The current character whose story is being played
var character := Character.new()

## The stories that are available to draw from when a new one is needed
##
## The values are resource paths.
var available_stories : Array[String] = []

## The end stories that have been added to the world
var end_stories : Array[String] = []

## The cast of characters as a map from name to npc object
var cast := Cast.new()

## All the locations
var game_map := GameMap.new()

var turns_per_year := MAX_TURNS_PER_YEAR

## The number of turns the player has taken.
##
## A turn is a complete story, from beginning to end, that consists of one
## logical unit of time.
var turns := 0:
	set(value):
		turns = value
		turns_changed.emit(turns)


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
