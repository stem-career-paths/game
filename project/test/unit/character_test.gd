extends GutTest

## Character.ATTRIBUTE_NAMES is used outside of this class,
## so this test ensures that the names line up with the fields.
func test_attribute_names_constant_matches_attributes():
	var character := Character.new()
	for attribute_name in Character.ATTRIBUTE_NAMES:
		assert_true(attribute_name in character)


## Tests that the character's attributes are all zero by default.
func test_attributes_are_all_zero_by_default():
	var character := Character.new()
	for attribute_name in Character.ATTRIBUTE_NAMES:
		assert_true(character.get(attribute_name) == 0)


## Tests that the character's highest attributes are all by default.
func test_highest_attributes_initially_has_all():
	var character := Character.new()

	var highest_attributes := character.highest_attributes()

	assert_true(highest_attributes.size() == 4)
	assert_true(highest_attributes.has("science"))
	assert_true(highest_attributes.has("technology"))
	assert_true(highest_attributes.has("engineering"))
	assert_true(highest_attributes.has("mathematics"))


## Tests that the character's highest attributes update when the character's
## attributes are updated.
func test_highest_attributes_has_one():
	var attributes := ["science", "technology", "engineering", "mathematics"]

	for attribute in attributes:
		var character := Character.new()
		character.set(attribute, 1)

		var highest_attributes := character.highest_attributes()

		assert_true(highest_attributes.size() == 1)
		assert_true(highest_attributes.has(attribute))


## Tests that the character's multiple highest attributes update when the 
## character's attributes are updated.
func test_highest_attributes_has_multiple():
	var character := Character.new()
	character.set("science", 1)
	character.set("engineering", 1)

	var highest_attributes := character.highest_attributes()

	assert_true(highest_attributes.size() == 2)
	assert_true(highest_attributes.has("science"))
	assert_true(highest_attributes.has("engineering"))


## Tests that the character's lowest attributes are all by default.
func test_lowest_attributes_initially_has_all():
	var character := Character.new()

	var lowest_attributes := character.lowest_attributes()

	assert_true(lowest_attributes.size() == 4)
	assert_true(lowest_attributes.has("science"))
	assert_true(lowest_attributes.has("technology"))
	assert_true(lowest_attributes.has("engineering"))
	assert_true(lowest_attributes.has("mathematics"))


## Tests that the character's lowest attributes update when the character's
## attributes are updated.
func test_lowest_attributes_has_one():
	var attributes := ["science", "technology", "engineering", "mathematics"]

	for attribute in attributes:
		var character := Character.new()
		character.set(attribute, -1)

		var lowest_attributes := character.lowest_attributes()

		assert_true(lowest_attributes.size() == 1)
		assert_true(lowest_attributes.has(attribute))


## Tests that the character's multiple lowest attributes update when the
## character's attributes are updated.
func test_lowest_attributes_has_multiple():
	var character := Character.new()
	character.set("science", -1)
	character.set("engineering", -1)

	var lowest_attributes := character.lowest_attributes()

	assert_true(lowest_attributes.size() == 2)
	assert_true(lowest_attributes.has("science"))
	assert_true(lowest_attributes.has("engineering"))
