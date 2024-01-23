extends Control

@export var max_value := 4
var character : Character:
	set(value):
		assert(value!=null, "Character cannot be set to null")
		assert(character==null, "Character can only be set once.")
		character = value
		for attribute_name in Character.ATTRIBUTE_NAMES:
			var node := find_child(attribute_name.to_pascal_case())
			var attribute := character[attribute_name] as Attribute
			node.attribute = attribute
			_attribute_nodes.append(node)
			
		assert(_attribute_nodes.size() == Character.ATTRIBUTE_NAMES.size())

var _attribute_nodes := []


func update_instantly() -> void:
	for node in _attribute_nodes:
		node.update_instantly()


func update_smoothly() -> void:
	for node in _attribute_nodes:
		node.update_smoothly()
