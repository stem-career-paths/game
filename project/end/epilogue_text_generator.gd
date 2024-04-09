class_name EpilogueTextGenerator extends RefCounted

const MEAN_POSTLUDE_THRESHOLD := 3

func generate_gap_year_text(_epilogue:Epilogue) -> Array[EpilogueText]:
	var job : String = [
		"retail",
		"as a barista",
		"construction",
		"at a big box store",
		"at a warehouse",
		"in a factory",
	].pick_random()
	var reason : String = [
		"save money",
		"figure out what you want to do",
		"help your family",
		"get some work experience",
		"buy a car",
		"establish credit",
	].pick_random()
	
	return [
		_p("You take a"),
		_h("gap year"),
		_p("working %s to %s." % [job,reason]),
	]


func generate_community_college_text(_epilogue:Epilogue) -> Array[EpilogueText]:
	var reason : String = [
		"and earn an associate's degree",
		"to complete some core courses that will transfer to a four-year school",
		"so that you can learn independence, practice college-level study skills, and save tuition money"
	].pick_random()
	
	return [
		_p("You attend"),
		_h("Community College"),
		_p(reason)
	]

func generate_university_text(epilogue:Epilogue) -> Array[EpilogueText]:
	return [
		_p("You enroll at a"),
		_h(Epilogue.as_string(epilogue.college_type)),
		_p("and major in"),
		_h(epilogue.majors[0].capitalize()),
		_p("because of your interest in %s." % epilogue.major_causes[0].capitalize()),
		_p(""),
		_p(epilogue.experience)
	]


## Generate the text for the postlude, which is between the university info
## and the summary.
##
## This can return an empty array if there is no postlude for this epilogue.
func generate_postlude_text(epilogue:Epilogue) -> Array[EpilogueText]:
	# Although ugly, the _p() arguments must be on one line or it
	# interferes with the formatting
	if epilogue.character.has_tag(Tags.Tag.JOINED_ROBOTICS_TEAM):
		return [
			_p("Your time on the robotics club helped you learn to work on a team and deal with stress. You joined an undergraduate research team, working closely with a professor and students from many different majors"),
		]
	if epilogue.character.amount_of_tag(Tags.Tag.MEAN_TO_OTHERS) >= MEAN_POSTLUDE_THRESHOLD:
		return [
			_p("Despite how well you did in high school, it was hard to make friends. People thought you were too mean. Every day you ate lunch alone. Every time someone tried to be nice to you, you yelled at them and said harsh things."),
			_p("Why would you do that?")
			
		]
	if epilogue.character.has_tag(Tags.Tag.JOINED_SCOUTS):
		return [
			_p("Between high school and college, you got involved with your local scouts. Since you're too old to remain involved in college, you spend your free time doing many scoutly things, like fishing, hiking, and memorizing obscure nature trivia.")
		]
	return []
	

# "p" as in "paragraph" from HTML.
func _p(s:String) -> EpilogueText:
	return EpilogueText.create_paragraph(s)


# "h" as in "heading" from HTML.
func _h(s:String) -> EpilogueText:
	return EpilogueText.create_main_point(s)
