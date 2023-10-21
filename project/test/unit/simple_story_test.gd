extends GutTest


func test_run__on_option_selected_is_called_if_present() -> void:
	var presenter = autofree(MockPresenter.new())
	var story = preload("res://test/unit/sample_simple_story.gd").new()
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

