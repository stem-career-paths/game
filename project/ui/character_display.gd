extends Control

const _ATTRIBUTES := [
	"Science",
	"Technology",
	"Engineering",
	"Mathematics",
	"Engagement",
	"Resilience",
	"Curiosity"
]

var character : Character

func _process(_delta):
	assert(character!=null, "character must be set before the game begins")
	for attribute in _ATTRIBUTES:
		var value = character.get(attribute.to_lower())
		var node_name = attribute + "Value"
		find_child(node_name).text = str(value)
