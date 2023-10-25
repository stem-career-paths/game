## The state of the game world
class_name World extends RefCounted

signal turns_changed(new_turn : int)

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

var turns_per_year := 2

## The number of turns the player has taken.
##
## A turn is a complete story, from beginning to end, that consists of one
## logical unit of time.
var turns := 0:
	set(value):
		turns = value
		turns_changed.emit(turns)
