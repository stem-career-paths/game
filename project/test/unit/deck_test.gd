extends GutTest

var deck : Deck

func before_each():
	deck = Deck.new()


func test_is_empty():
	assert_true(deck.is_empty())
	_add_card_to_deck()
	assert_false(deck.is_empty())


func test_draw__reduces_deck_size():
	for i in 2:
		_add_card_to_deck()
	assert_eq(deck.size(), 2)
	deck.draw()
	assert_eq(deck.size(), 1)


func _add_card_to_deck():
	deck.add(double(StoryCard).new())
