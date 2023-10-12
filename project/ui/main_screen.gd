extends Control

const _STARTING_STORY_PATH := "res://story/starting_stories/"
const _CAST_PATH := "res://cast/"

signal _option_selected(option: String)

## The number of stories that, when complete, the game is over
@export var max_stories := 4

@export_category("Animation")

## How long it takes a new "card" to slide in on top of the stack.
@export var slide_in_duration := 0.35

## How long it takes for the bottom card to fade out as a new card
## slides in on top of it.
@export var bottom_card_modulate_duration := 0.15


@export_category("Manual Testing")
## Forces the application to start with a particular story.
@export_file("*.gd") var starting_story

var world : World

## A reference to the current top card.
##
## This is used by the card animation system. It does not have a meaningful
## value in the middle of an animation.
var _current_card : Node

## The number of stories completed so far
var _stories_complete := 0

## The position from which a new card starts when sliding in
@onready var _max_x : int = ProjectSettings.get_setting("display/window/size/viewport_width")


func _ready():
	# Initialize the world
	world = World.new()
	world.cast.load_cast(_CAST_PATH)
	
	## Load all the stories in _STARTING_STORY_PATH
	var file_paths := DirAccess.get_files_at(_STARTING_STORY_PATH)
	for file_path in file_paths:
		world.available_stories.append(_STARTING_STORY_PATH + file_path)
	
	while _stories_complete < max_stories:
		if world.available_stories.is_empty():
			# This would happen if there are no available stories to run.
			# We should design the game so that this can't happen.
			# Hence, we push an error in this case, since we have done
			# something wrong... and should probably write automated tests
			# to ensure it doesn't happen again.
			push_error("Ran out of stories!")
			break
		else:
			await _run_next_story()
			_stories_complete += 1
	
	var game_over_card := preload("res://ui/game_over_card.tscn").instantiate()
	game_over_card.world = world
	_show_card(game_over_card)


# Draw a random story and run it.
func _run_next_story() -> void:
	var story_path : String
	
	# Determine the next story based on whether we are forcing one or not.
	if starting_story == null:
		story_path = _draw_random_story()
	
	# If we are testing a particular story, go get that one, and remove
	# it from the collection if it had been there to prevent repeats.
	else:
		print("Forcing starting story: ", starting_story)
		story_path = starting_story
		world.available_stories.erase(starting_story)
		starting_story = null
	
	## Load the story and start it
	var story = load(story_path).new()
	var card := preload("res://card/story_card.tscn").instantiate()
	card.world = world
	_show_card(card)
	await story.run(card, world)


func _draw_random_story() -> String:
	var story_path : String = world.available_stories.pick_random()
	world.available_stories.erase(story_path)
	return story_path


## Show a given card as the new top card.
func _show_card(card : Node) -> void:
	# If there already is a card, fade it out and start the new card offscreen.
	if _current_card!=null:
		create_tween().tween_property(_current_card, "modulate", Color.GRAY, bottom_card_modulate_duration)	
		card.position.x = _max_x
	
	add_child(card)
	
	# If there was a card, slide the new one over it.
	if _current_card != null:
		var tween := get_tree().create_tween()
		var previous_card = _current_card
		tween.tween_property(card, "position", Vector2.ZERO, slide_in_duration)\
			.set_ease(Tween.EASE_IN)
		# Remove the card in the background once it is covered up
		tween.tween_callback(func(): 
			if previous_card != null:
				remove_child(previous_card)
		)

	_current_card = card
