extends GutTest

var cast : Cast

func before_each() -> void:
	cast = Cast.new()

func test_load_cast() -> void:
	_load_test_data()
	assert_eq(cast.size(), 1, "The right number of test cast members are loaded.")
	

func _load_test_data() -> void:
	cast.load_cast("res://test/integration/test_cast/")


func test_get_by_name() -> void:
	_load_test_data()
	var npc := cast.get_by_name("Bobby Tables")
	assert_not_null(npc)
	
