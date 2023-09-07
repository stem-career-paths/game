## The state of the game world
class_name World extends RefCounted

const _STORY_DIR := "res://story/"

signal card_changed(card:StoryCard)

## The current character whose story is being played
var character := Character.new()

## The deck of cards from which story cards are drawn
var deck := Deck.new()

## The current card which may be null if there is not one.
var card : StoryCard = null:
	set(new_card):
		if card != new_card:
			card = new_card
			card_changed.emit(card)


func _init():
	var parser := StoryCardParser.new()
	
	var story_dir := DirAccess.open(_STORY_DIR)
	for filename in story_dir.get_files():
		var file := FileAccess.open(_STORY_DIR + filename, FileAccess.READ)
		var decoded_card := parser.parse(file.get_as_text())
		deck.add(decoded_card)
