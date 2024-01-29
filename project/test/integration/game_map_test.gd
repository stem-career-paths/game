extends GutTest

func test_load() -> void:
	var map := GameMap.new()
	map.load("res://test/integration/test_locations/")
	
	assert_eq(map.size(), 1, "One location should be loaded from the test locations.")
	assert_true(map.has_location("test_location"), "The map should have loaded the test location")
	assert_not_null(map.get_by_name("test_location"), "The location texture can be loaded by name")
	
