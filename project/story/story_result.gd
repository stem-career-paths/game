class_name StoryResult extends RefCounted

var _text : String


func _init(text:String):
	_text = text


func get_text(_world:World)->String:
	return _text
