class_name Deck extends RefCounted

var _cards : Array[StoryCard] = []

## Add a card to the bottom of the deck
func add(card:StoryCard)->void:
	assert(card!=null)
	_cards.append(card)


## Draw and return the top card of the deck
func draw()->StoryCard:
	var card := _cards[0]
	_cards.remove_at(0)
	return card


## Check if the deck is empty
func is_empty()->bool:
	return _cards.is_empty()


## Get the number of cards in the deck
func size()->int:
	return _cards.size()
