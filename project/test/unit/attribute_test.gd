extends GutTest

const EPSILON := 0.001

var _attribute : Attribute

func before_each():
	_attribute = autofree(Attribute.new())
	

func test_get_ratio__zero():
	assert_eq(_attribute.get_ratio(), 0.0, "Initial ratio should be zero")


func test_get_ratio__half():
	_attribute.value = 2
	_attribute.max_value = 4
	assert_almost_eq(_attribute.get_ratio(), 0.5, EPSILON, "Attribute 2 with max 4 should have ratio 0.5")


func test_get_ratio__over_one():
	_attribute.value = 2
	_attribute.max_value = 1
	assert_eq(_attribute.get_ratio(), 1.0, "Ratio won't go over 1.0 even if value > max_value")


func test_get_ratio__under_zero():
	_attribute.value = -1
	assert_eq(_attribute.get_ratio(), 0.0, "Ratio is zero even if set value is negative")


func test_value__cannot_be_set_to_negative():
	_attribute.value = -1
	assert_eq(_attribute.value, 0, "Negative values for the attribute become zero")
