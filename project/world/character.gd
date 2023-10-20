## A playable character in the game.
##
## This holds the information that is needed to run a session of the game.
class_name Character extends RefCounted

const ATTRIBUTE_NAMES : Array[String] = [
	"science",
	"technology",
	"engineering",
	"mathematics",
	"engagement",
	"resilience",
	"curiosity",
]

var science := 0
var technology := 0
var engineering := 0
var mathematics := 0

var engagement := 0
var resilience := 0
var curiosity := 0


## Get the names of the highest attributes
##
## If a filter is provided, only consider those attributes named in the filter.
func get_highest_attribute_names(filter : Array[String] = ATTRIBUTE_NAMES) -> Array[String]:
	var attribute_names := ATTRIBUTE_NAMES.filter(func(name): return filter.has(name))
	attribute_names.sort_custom(func(a,b): return get(a) > get(b))
	var maximal_value : int = get(attribute_names[0])
	var result := attribute_names.filter(func(a): return get(a) == maximal_value)
	var typed_returnable : Array[String] = []
	typed_returnable.assign(result)
	return typed_returnable
