## A SimpleStory subclass that is useful for testing
##
## Making this an inner class of the simple_story_test.gd caused gut 
## to generate warnings, although only when it was run on the command line.
extends SimpleStory

var notification_called := false
var selected_option : String = "" # Will be overridden by the notification response

var text := "I have text"
var options := {
	"The Only Option": {
		"text": "The result",
	}
}

func on_option_selected(option : String, _world : World) -> void:
	notification_called = true
	selected_option = option
