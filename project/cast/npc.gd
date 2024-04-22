class_name Npc extends RefCounted

const _UNDERCLASS_YEARS := [Year.Name.FRESHMAN, Year.Name.SOPHOMORE ]

var name : String
var student : bool
var images : Array[Texture]

func get_image(year : Year.Name) -> Texture:
	if not student:
		return images[0]
	elif _UNDERCLASS_YEARS.has(year):
		return images[0]
	else:
		return images[1]
