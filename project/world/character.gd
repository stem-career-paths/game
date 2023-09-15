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
