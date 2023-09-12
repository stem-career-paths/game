extends GutTest

## Character.ATTRIBUTE_NAMES is used outside of this class,
## so this test ensures that the names line up with the fields.
func test_attribute_names_constant_matches_attributes():
	var character := Character.new()
	for attribute_name in Character.ATTRIBUTE_NAMES:
		assert_true(attribute_name in character)
