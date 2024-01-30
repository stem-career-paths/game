extends Control

const _STARTING_STORY_PATH := "res://story/starting_stories/"
const _CAST_PATH := "res://cast/"
const _LOCATIONS_PATH := "res://locations/"

signal _option_selected(option: String)

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

## The number of stories completed so far
var _stories_complete := 0

@onready var _game_screen := $GameScreen


func _ready():
	# Log the start of the game
	GameLog.start_game()
	
	# Initialize the world
	world = World.new()
	world.cast.load_cast(_CAST_PATH)
	world.game_map.load(_LOCATIONS_PATH)
	_game_screen.world = world
	
	## Load all the stories in _STARTING_STORY_PATH
	var file_paths := DirAccess.get_files_at(_STARTING_STORY_PATH)
	for file_path in file_paths:
		world.available_stories.append(_STARTING_STORY_PATH + file_path)
	
	while _stories_complete < world.turns_per_year * 4:
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
	
	await _game_screen.finish_game()
	var start_scene :Control = load("res://ui/start_scene.tscn").instantiate()
	owner.change_scene(start_scene)


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
	await story.run(_game_screen)
	world.turns += 1


func _draw_random_story() -> String:
	var story_path : String = world.available_stories.pick_random()
	world.available_stories.erase(story_path)
	return story_path


func set_turns_per_year(turns: int) -> void:
	world.turns_per_year = turns
