extends Node


const STORY_PATH := "res://story/"

@export var _auto_run := false
@onready var _presenter = load("res://tools/story_tester/test_presenter.gd").new()


func _ready() -> void:
	if _auto_run:
		var result := await test_stories()
		print(JSON.stringify(result, "  "))



func test_stories() -> Dictionary:
	var story_files := _get_story_files()
	var _effects := {}

	for story_file in story_files:
		_effects[story_file] = await _presenter.test(STORY_PATH + story_file)

	return _effects


func _get_story_files() -> Array[String]:
	var story_dir := DirAccess.open(STORY_PATH)

	var story_files: Array[String] = []

	for file_name in story_dir.get_files():
		if file_name == "meta_story.gd":
			continue

		var file_path := file_name
		story_files.append(file_path)

	return story_files


