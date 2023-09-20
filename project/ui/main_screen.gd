extends Control

const _STARTING_STORY_PATH := "res://story/starting_stories/"

signal _option_selected(option: String)

enum _EntranceType { FIXED, ANIMATED }

@export_file("*.gd") var initial_story 
@export var slide_in_duration := 0.35

var world := World.new()
var _max_x := 750

var _current_card : Node

func _ready():
	var file_paths := DirAccess.get_files_at(_STARTING_STORY_PATH)
	for file_path in file_paths:
		world.available_stories.append(_STARTING_STORY_PATH + file_path)
	world.available_stories.shuffle()
	
	while not world.available_stories.is_empty():
		var story_path : String = world.available_stories.pop_front()
		var story = load(story_path).new()
		await _show_card(story, _EntranceType.FIXED if _current_card==null else _EntranceType.ANIMATED)
		
	print("THERE ARE NO MORE STORIES")


func _show_card(story : Object, entrance : _EntranceType) -> void:
	var presenter := preload("res://card/story_card.tscn").instantiate()
	presenter.world = world
	
	if entrance == _EntranceType.ANIMATED:
		presenter.position.x = _max_x
	
	add_child(presenter)
	
	if entrance == _EntranceType.ANIMATED:
		var tween := get_tree().create_tween()
		var previous_card = _current_card
		tween.tween_property(presenter, "position", Vector2.ZERO, slide_in_duration)\
			.set_ease(Tween.EASE_IN)
		# Remove the card in the background once it is covered up
		tween.tween_callback(func(): 
			if previous_card != null:
				remove_child(previous_card)
		)

	_current_card = presenter
	await story.run(presenter)
