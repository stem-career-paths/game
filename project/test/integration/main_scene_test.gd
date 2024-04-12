extends GutTest

# Being able to specify the starting story is great for local testing,
# but more than once, we have accidentally pushed this to production.
# This integration test checks for that case.
func test_starting_story_is_not_set() -> void:
	var scene = autofree(preload("res://ui/main_scene.tscn").instantiate())
	assert_null(scene.starting_story, "Starting story should not be set in production")
