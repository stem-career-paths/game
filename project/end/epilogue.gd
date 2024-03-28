class_name Epilogue extends RefCounted

## Probability of taking a gap year
##
## This is completely made up. We could do some research for better data here.
const GAP_YEAR_CHANCE := 0.15

## Probability of going to 2-year college vs 4-year college
##
## This is computed by the ratio reported by NCES in 2019.
const COMMUNITY_COLLEGE_PROBABILITY := 0.22/0.66

const MAJORS_BY_ATTRIBUTE := {
	"science": [
		"astronomy",
		"biology",
		"chemistry",
		"computer science",
		"geology",
		"physics",
		"psychology",
	],
	"technology": [
		"computer networking",
		"cybersecurity",
		"information systems",
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

enum InstitutionType {
	PRIVATE_LIBERAL_ARTS,
	PRIVATE_ENGINEERING,
	SMALL_PUBLIC,
	MEDIUM_PUBLIC,
	LARGE_PUBLIC
}

var character : Character

var gap_year := false

var community_college := false

var college_type : InstitutionType = InstitutionType.MEDIUM_PUBLIC

## The majors declared
var majors : Array[String] = []
## The attribute contributing to the selection of major.
## Indices correspond to those of the majors.
var major_causes : Array[String] = []

var minors : Array[String] = []


func _init(character_p:Character) -> void:
	assert(character_p!=null, "Character must be specified")
	character = character_p


@warning_ignore("shadowed_variable")
static func create_for(character:Character) -> Epilogue:
	var epilogue := Epilogue.new(character)
	
	if randf() < GAP_YEAR_CHANCE:
		epilogue.gap_year = true
	
	if randf() < COMMUNITY_COLLEGE_PROBABILITY:
		epilogue.community_college = true
	
	# Even chance of the institution types. This can be improved later as desired.
	epilogue.college_type = InstitutionType.keys().pick_random()
	
	# Determine major by highest attribute
	var keys: Array[String] = []
	keys.assign(MAJORS_BY_ATTRIBUTE.keys())
	var highest_attribute_name: String = \
		character.get_highest_attribute_names(keys).pick_random()
	var major := MAJORS_BY_ATTRIBUTE[highest_attribute_name].pick_random() as String
	epilogue.majors.append(major)
	epilogue.major_causes.append(highest_attribute_name)
	
	return epilogue


static func as_string(type:InstitutionType) -> String:
	match type:
		InstitutionType.PRIVATE_LIBERAL_ARTS: 
			return "Private Liberal Arts College"
		InstitutionType.PRIVATE_ENGINEERING:
			return "Private Engineering College"
		InstitutionType.SMALL_PUBLIC:
			return "Small Public College"
		InstitutionType.MEDIUM_PUBLIC:
			return "Mid-Sized Public University"
		InstitutionType.LARGE_PUBLIC:
			return "Large Public University"
	assert(false, "Unreachable code if the match is working above.")
	return ""
