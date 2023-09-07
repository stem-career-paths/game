class_name StoryEffect extends RefCounted

var attribute_name : String
var value := 0

func apply(world:World)->void:
	var character := world.character
	character[attribute_name] = value
