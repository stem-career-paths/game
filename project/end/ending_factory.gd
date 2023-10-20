extends RefCounted

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

const _END_STORY_PATH := "res://end/"

const _MAJORS_BY_ATTRIBUTE := {
	"science" : [
		"astronomy",
		"biology",
		"chemistry",
		"computer science",
		"geology",
		"physics",
		"psychology",
	],
	"technology": [
		"cybersecurity",
		"information technology",
	],
	"engineering": [
		"civil engineering",
		"chemical engineering",
		"computer engineering",
		"electrical engineering",
		"mechanical engineering",
	],
	"mathematics": [
		"data science",
		"mathematics",
		"statistics",
	],
}

func make_ending_story(world : World) -> String:
	if world.end_stories.size() > 0:
		return _pick_random_canned_end_story(world)
	else:
		return _generate_random_ending(world)


func _pick_random_canned_end_story(world : World) -> String:
	assert(not world.end_stories.is_empty())
	var end_story_name := world.end_stories[randi() % world.end_stories.size()]
	var end_story = load("%send_%s.gd" % [_END_STORY_PATH, end_story_name]).new()
	return end_story.text


func _generate_random_ending(world : World) -> String:
	var result := ""

	if randf() > _HIGHER_ED_PROBABILITY:
		result += _generate_gap_year_text() + " "
	
	if randf() <= _COMMUNITY_COLLEGE_PROBABILITY:
		result += "You go to community college %s " % [
			"and earn an associate's degree. Then, you go ",
			"to complete some core courses like writing and global studies. Then, you transfer "
		].pick_random()
		result += "to %s" % [
			"a state university",
			"a state college",
		].pick_random()
	else:
		result += "You attend %s" % [
			"a small liberal arts college",
			"a state university",
			"a state college"
		].pick_random()
	
	result += " and major in %s." % _pick_major(world.character).capitalize()

	return result


func _generate_gap_year_text() -> String:
	return "You take a gap year after high school, working %s." % [
		"retail",
		"as a barista",
		"construction",
		"at a big box store",
		"at a warehouse",
		"in a factory",
	].pick_random()


func _pick_major(character : Character) -> String:
	var keys : Array[String] = []
	keys.assign(_MAJORS_BY_ATTRIBUTE.keys())
	var highest_attribute_name : String = \
		character.get_highest_attribute_names(keys).pick_random()
	return _MAJORS_BY_ATTRIBUTE[highest_attribute_name].pick_random() as String
	
