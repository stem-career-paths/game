extends VBoxContainer

signal dismissed

var result : StoryResult
var world : World

@onready var _story_label := $Story
@onready var _effects_box := %EffectsBox


func _ready():
	assert(result!=null, "result must be specified")
	assert(world!=null, "world must be specified")
	_story_label.text = result.get_text(world)
	
	var effects := result.get_effects()
	for attribute in effects.keys():
		var modifier = effects[attribute]
		var label := Label.new()
		label.text = "%s %+d" % [attribute.to_pascal_case(), modifier]
		_effects_box.add_child(label)


func _on_ok_button_pressed():
	dismissed.emit()
