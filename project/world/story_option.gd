## Data model for an option that the player can select from
class_name StoryOption extends RefCounted

## The text that could be shown on a button
var text : String

## The identifier (path?) of the story card to go to if this is selected
var next : String

## The effects that this option has on the world
var effects : Array[StoryEffect] = []


## Create a story card to show for when this option is selected.
func make_card()->StoryCard:
	var card := StoryCard.new()
	card.text = text
	card.effects.append_array(effects)
	return card
