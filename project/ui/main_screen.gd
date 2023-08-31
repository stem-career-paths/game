extends Control

var world := World.new()
var story_event := StoryEvent.new()

func _ready():
	# Create the character for this session.
	world.character = Character.new()
	%CharacterDisplay.character = world.character
	
	# Set up the game UI
	var story_event_display := preload("res://ui/story_event_display.tscn").instantiate()
	story_event_display.story_event = story_event
	story_event_display.world = world
	%StoryArea.add_child(story_event_display)
	
	story_event_display.selected.connect(func(option:StoryOption):
		%StoryArea.remove_child(story_event_display)
		
		var result_display := preload("res://ui/story_result_display.tscn").instantiate()
		result_display.result = option.result
		result_display.world = world
		%StoryArea.add_child(result_display)
		
		option.result.apply_result(world)
		
		# For now, continuing the story just repeaats the same one again.
		# It's simple and will be replaced with something like a deck of
		# story cards later.
		result_display.dismissed.connect(func():
			%StoryArea.remove_child(result_display)
			%StoryArea.add_child(story_event_display)
		)
	)
	
