## A playable character in the game.
##
## This holds the information that is needed to run a session of the game.
class_name Character extends RefCounted

const ATTRIBUTE_NAMES := [
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


func highest_attributes() -> Array[String]:
	var current_highest: Array[String] = [ATTRIBUTE_NAMES[0]]
	var current_highest_value: int = get(current_highest[0])

	for i in range(1, 4):
		var attribute: String = ATTRIBUTE_NAMES[i]
		var value: int = get(attribute)

		if value > current_highest_value:
			current_highest = [attribute]
			current_highest_value = value

		elif value == current_highest_value:
			current_highest.append(attribute)

	return current_highest


func lowest_attributes() -> Array[String]:
	var current_lowest: Array[String] = [ATTRIBUTE_NAMES[0]]
	var current_lowest_value: int = get(current_lowest[0])

	for i in range(1, 4):
		var attribute: String = ATTRIBUTE_NAMES[i]
		var value: int = get(attribute)

		if value < current_lowest_value:
			current_lowest = [attribute]
			current_lowest_value = value

		elif value == current_lowest_value:
			current_lowest.append(attribute)

	return current_lowest
