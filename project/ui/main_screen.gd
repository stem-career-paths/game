extends Control


func _ready():
	var world := World.new()
	var story_event := StoryEvent.new()
	
	var story_event_display := preload("res://ui/story_event_display.tscn").instantiate()
	story_event_display.story_event = story_event
	story_event_display.world = world
	add_child(story_event_display)
	
	story_event_display.selected.connect(func(option:StoryOption):
		remove_child(story_event_display)
		
		var result_display := preload("res://ui/story_result_display.tscn").instantiate()
		result_display.result = option.result
		result_display.world = world
		add_child(result_display)
		
		result_display.dismissed.connect(func():
			get_tree().reload_current_scene()
		)
	)
	
