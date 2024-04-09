@tool
class_name SummaryItem extends Control

enum Type {
	TIME,
	INSTITUTION,
	DEGREE,
}

const _ICONS := {
	Type.TIME: preload("res://ui/epilogue/clock.png"),
	Type.INSTITUTION: preload("res://ui/epilogue/college.png"),
	Type.DEGREE: preload("res://ui/epilogue/diploma.png"),
}

@export var text := "Text goes here":
	set(value):
		text = value
		%Label.text = text

@export var type := Type.TIME:
	set(value):
		type = value
		%TextureRect.texture = _ICONS[type]
