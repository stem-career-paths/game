extends GutTest

const STARTING_STORY_DIR := "res://story/starting_stories/"

func test_there_are_stories_enough_to_fill_a_playthrough() -> void:
	var world := World.new()
	var dir := DirAccess.open(STARTING_STORY_DIR)
	var files := dir.get_files()
	var count := 0
	for file_name in files:
		if file_name.ends_with(".gd"):
			count += 1
	
	var needed_stories := world.turns_per_year * 4
	
	assert_true(count >= needed_stories, "Not enough stories. We need at least %d but there are %d." % [
		needed_stories,
		count
	])
