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


func test_get_highest_attribute_names__one_is_highest():
	var attributes := ["science", "technology", "engineering", "mathematics"]

	for attribute in attributes:
		var character := Character.new()
		character.set(attribute, 1)

		var get_highest_attribute_names := character.get_highest_attribute_names()

		assert_true(get_highest_attribute_names.size() == 1)
		assert_true(get_highest_attribute_names.has(attribute))


func test_get_highest_attribute_names__multiple_highest():
	var character := Character.new()
	character.set("science", 1)
	character.set("engineering", 1)

	var get_highest_attribute_names := character.get_highest_attribute_names()

	assert_eq(get_highest_attribute_names.size(), 2)
	assert_true(get_highest_attribute_names.has("science"))
	assert_true(get_highest_attribute_names.has("engineering"))


func test_get_highest_attribute_names__using_filter_parameter() -> void:
	var character := Character.new()
	character.set("science", 1)
	character.set("engineering", 1)
	
	var highest := character.get_highest_attribute_names(["science"])
	
	assert_eq(highest, ["science"])
