## The data structure for a "card" that is shown to the player.
## It represents a single atomic interaction with the game.
class_name StoryCard extends RefCounted

## The text to be displayed on the card.
var text : String

## The options that the player can choose from.
var options: Array[StoryOption] = []

## Effects that this card applies when it is shown.
var effects: Array[StoryEffect] = []
