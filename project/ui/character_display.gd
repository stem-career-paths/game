extends Control

@export var max_value := 4
var character : Character

func _process(_delta):
	assert(character!=null, "character must be set before the game begins")
	for attribute in Character.ATTRIBUTE_NAMES:
		var node := find_child(attribute.to_pascal_case())
		var value = character[attribute]
		node.ratio = min(float(value) / max_value, 1)
