extends GutTest

var character : Character


func before_each() -> void:
	character = Character.new()


## Character.ATTRIBUTE_NAMES is used outside of this class,
## so this test ensures that the names line up with the fields.
func test__attribute_names_constant_matches_attributes():
	for attribute_name in Character.ATTRIBUTE_NAMES:
		assert_true(attribute_name in character)


func test__attributes_are_all_zero_by_default():
	for attribute_name in Character.ATTRIBUTE_NAMES:
		assert_eq(character.get(attribute_name), 0)


func test_get_highest_attribute_names__one_is_highest():
	var attributes := ["science", "technology", "engineering", "mathematics"]

	for attribute in attributes:
		character = Character.new()
		character.set(attribute, 1)

		var get_highest_attribute_names := character.get_highest_attribute_names()

		assert_eq(get_highest_attribute_names.size(), 1)
		assert_true(get_highest_attribute_names.has(attribute))


func test_get_highest_attribute_names__multiple_highest():
	character.set("science", 1)
	character.set("engineering", 1)

	var get_highest_attribute_names := character.get_highest_attribute_names()

	assert_eq(get_highest_attribute_names.size(), 2)
	assert_true(get_highest_attribute_names.has("science"))
	assert_true(get_highest_attribute_names.has("engineering"))


func test_get_highest_attribute_names__using_filter_parameter() -> void:
	character.set("science", 1)
	character.set("engineering", 1)
	
	var highest := character.get_highest_attribute_names(["science"])
	
	assert_eq(highest, ["science"])
