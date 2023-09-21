## The state of the game world
class_name World extends RefCounted

## The current character whose story is being played
var character := Character.new()

## The stories that are available to draw from when a new one is needed
##
## The values are resource paths.
var available_stories : Array[String] = []

## The cast of characters as a map from name to npc object
var cast := Cast.new()
