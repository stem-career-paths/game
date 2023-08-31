class_name StoryResult extends RefCounted

var _text : String

## The attribute-changing effects of this result.
## 
## The keys are character attribute names and the values are numbers that are
## added to those attributes.
var _effects : Dictionary

func _init(text:String, effects : Dictionary = {}):
	_text = text
	_effects = effects


func get_effects()->Dictionary:
	return _effects


func get_text(_world:World)->String:
	return _text


func apply_result(world:World)->void:
	for key in _effects.keys():
		var original_value = world.character.get(key)
		var new_value = original_value + _effects[key]
		world.character.set(key, new_value)
