extends VBoxContainer

signal selected(option)

var story_event : StoryEvent
var world : World

@onready var _story_text := $StoryText
@onready var _options_box := $OptionsBox

func _ready():
	assert(story_event!=null, "story_event must be specified prior to adding to node tree")
	assert(world!=null, "world must be specified prior to adding to node tree")
	_story_text.text = story_event.get_intro_text(world)
	for option in story_event.get_options(world):
		var button := Button.new()
		button.text = option.text
		button.pressed.connect(func():
			selected.emit(option)
		)
		_options_box.add_child(button)


