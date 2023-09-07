class_name StoryLoader extends RefCounted

func load_cards(story_manager: StoryManager) -> void:
	# Load all the cards
	# Structure: res://story/<pack>/<id>.gd
	# ID can include subdirectories
	# (e.g. res://story/base_set/bird_banding/intro.gd becomes "bird_banding/intro")
	var card_files = _recurse_dir()

	for file in card_files:
		_load_card(file, story_manager)


func _load_card(file: String, story_manager: StoryManager) -> void:
	var card_data = _parse_file(file)

	var card := load("res://story" + file).new() as StoryCard
	card.id = card_data.id
	card.pack = card_data.pack

	story_manager.cards.append(card)
	
	if card_data.intro:
		story_manager.deck.append(card)


func _parse_file(file: String) -> Dictionary:
	var result := {}

	var parts := file.substr(1).replace(".gd", "").split("/")

	result.pack = parts[0]
	result.id = "/".join(parts.slice(1))
	result.intro = parts[-1] == "intro"

	return result


func _recurse_dir(dir := "") -> Array[String]:
	var dir_access = DirAccess.open("res://story/" + dir)
	dir_access.list_dir_begin()

	var files: Array[String] = []

	while true:
		var file = dir_access.get_next()

		if file == "":
			break
		if file.ends_with(".gd"):
			files.append(dir + "/" + file)
		elif dir_access.current_is_dir():
			files.append_array(_recurse_dir(dir + "/" + file))
	
	return files
