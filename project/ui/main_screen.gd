extends Control

var world := World.new()

func _ready():
	%CharacterDisplay.character = world.character

	world.card_changed.connect(func(card):
		_show_card(card)
	)
	
	var first_card := world.deck.draw()
	world.card = first_card


func _show_card(card:StoryCard)->void:
	_clear(%StoryArea)
	
	var story_event_display := preload("res://ui/story_card_display.tscn").instantiate()
	story_event_display.card = card
	story_event_display.world = world
	%StoryArea.add_child(story_event_display)


func _clear(container:Control)->void:
	while container.get_child_count() > 0:
		container.remove_child(container.get_child(0))
