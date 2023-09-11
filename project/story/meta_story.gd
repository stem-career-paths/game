extends RefCounted

const _STORY_PATH := "res://story/"

func run(presenter):
	var story_dir := DirAccess.open(_STORY_PATH)
	
	var options := []
	
	for file_name in story_dir.get_files():
		if file_name != "meta_story.gd":
			var file_path := _STORY_PATH + file_name
			options.append(file_path)
	
	while true:
		var selection = await presenter.show_options(options)
		var object = load(selection).new()
		await object.run(presenter)
		
