extends Control

# According to the National Center for Education Statistics, in 2019 (the
# last prepandemic year), 66% of high school graduates when directly into
# higher education. This can be broken down into 22% into two-year schools
# and 44% into four-year schools. 
#
# See https://nces.ed.gov/fastfacts/display.asp?id=51
#
# These constants assume there's a 90% chance the student is going to college.
# That is completely arbitrary. The rest of the constants are computed from that
# given the data above.
const _HIGHER_ED_PROBABILITY := 0.9

## Probability of going to 2-year college vs 4-year college
##
## This is computed by the ratio reported by NCES in 2019.
const _COMMUNITY_COLLEGE_PROBABILITY := 0.22/0.66

const JOBS_DIRECTORY: String = "res://jobs/possible_jobs/"
const _END_STORY_PATH := "res://end/"

var world: World

@onready var _character_display := %CharacterDisplay
@onready var _result_label := %ResultLabel


func _ready():
	assert(world != null, "World must be specified")
	_character_display.character = world.character

	if world.end_stories.size() > 0:
		_result_label.text = _get_canned_end_story()
	else:
		_result_label.text = _generate_random_ending()


func _get_canned_end_story() -> String:
	var end_story_name := world.end_stories[randi() % world.end_stories.size()]
	var end_story = load("%send_%s.gd" % [_END_STORY_PATH, end_story_name]).new()
	return end_story.text


func _generate_random_ending() -> String:
	var result := ""

	# This demonstrates how the outcome will be multifaceted, considering 
	# things like gap years, community college.
	if randf() > _HIGHER_ED_PROBABILITY:
		result += "You take a gap year, working at a coffee shop to save some money. "
	if randf() <= _COMMUNITY_COLLEGE_PROBABILITY:
		result += "You attend a local community college and earn an associate's degree. "
	
	# This is just an example of how we will use character stats to determine 
	# outcomes. It should be replaced with something more robust.
	var character := world.character
	if character.science > character.engineering:
		result += "You finish a bachelors degree in Chemistry at a state university and get a job as a quality tester at a chemical plant."
	else:
		result += "You finish a bachelors degree in Mechanical Engineering and get a job at a military contractor."

	return result


func _on_play_again_button_pressed():
	# Naive implementation
	var main_scene: String = ProjectSettings.get_setting("application/run/main_scene")
	get_tree().change_scene_to_file(main_scene)
