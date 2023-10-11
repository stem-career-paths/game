extends GutTest


func test_run__on_option_selected_is_called_if_present() -> void:
	var presenter = autofree(MockPresenter.new())
	var story = TestStory.new()
	story.run(presenter)
	assert_true(story.notification_called)
	assert_eq(story.selected_option, story.options.keys()[0])


## A simulated presenter that contains only the minimal number
## of fields and methods to operate.
class MockPresenter extends RefCounted:
	var world : World = null
	
	func show_text(_text : String) -> void: 
		pass


	func show_options(options) -> String:
		return options[0]


	func finish() -> void:
		pass



class TestStory extends SimpleStory:
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
	
