class_name EpilogueTextGenerator extends RefCounted

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
		_p("because of your interest in %s" % epilogue.major_causes[0].capitalize())
	]
	

# "p" as in "paragraph" from HTML.
func _p(s:String) -> EpilogueText:
	return EpilogueText.create_paragraph(s)


# "h" as in "heading" from HTML.
func _h(s:String) -> EpilogueText:
	return EpilogueText.create_main_point(s)
