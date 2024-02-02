extends GutTest

const LOCATIONS_PATH := "res://locations/"

func test_load__all_files_in_folder_are_locations() -> void:
	var map := GameMap.new()
	
	var files_in_directory := 0
	for file_name in DirAccess.get_files_at(LOCATIONS_PATH):
		if file_name.ends_with(".png"):
			files_in_directory += 1

	assert_eq(map.size(), files_in_directory, "Number of locations matches number of .png images in %s" % LOCATIONS_PATH)
	
