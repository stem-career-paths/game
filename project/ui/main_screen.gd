extends Control

const _STARTING_STORY_PATH := "res://story/starting_stories/"

signal _option_selected(option: String)

enum _EntranceType { FIXED, ANIMATED }

## How long it takes a new "card" to slide in on top of the stack.
@export var slide_in_duration := 0.35

## How long it takes for the bottom card to fade out as a new card
## slides in on top of it.
@export var bottom_card_modulate_duration := 0.15

var world := World.new()

## A reference to the current top card.
##
## This is used by the card animation system. It does not have a meaningful
## value in the middle of an animation.
var _current_card : Node

## The position from which a new card starts when sliding in
@onready var _max_x : int = ProjectSettings.get_setting("display/window/size/viewport_width")


func _ready():
	## Load and randomize all the stories in _STARTING_STORY_PATH
	var file_paths := DirAccess.get_files_at(_STARTING_STORY_PATH)
	for file_path in file_paths:
		world.available_stories.append(_STARTING_STORY_PATH + file_path)
	world.available_stories.shuffle()
	
	while not world.available_stories.is_empty():
		var story_path : String = world.available_stories.pop_front()
		var story = load(story_path).new()
		await _show_card(story, _EntranceType.FIXED if _current_card==null else _EntranceType.ANIMATED)
	
	## It would be a design error to run out of stories without graceful
	## termination. This is a placeholder.
	push_error("THERE ARE NO MORE STORIES")


## Show a given card as the new top card.
func _show_card(story : Object, entrance : _EntranceType) -> void:
	# Fade out the old card if there is one
	if _current_card!=null:
		create_tween().tween_property(_current_card, "modulate", Color.GRAY, bottom_card_modulate_duration)	
	
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
