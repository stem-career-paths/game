extends GutTest

func test_for_orphans():
	var scene_definition = load("res://ui/game_screen.tscn")
	var scene = scene_definition.instantiate()
	add_child(scene)
	
	# Required to let the UI "settle" before checking the line count.
	await get_tree().process_frame
	
	scene.free()
	
	assert_no_new_orphans()
