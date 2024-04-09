@tool
class_name SummaryItem extends Control

enum Type {
	TIME,
	INSTITUTION,
	DEGREE,
}

const _ICONS := {
	Type.TIME: preload("res://ui/epilogue/clock.svg"),
	Type.INSTITUTION: preload("res://ui/epilogue/university.svg"),
	Type.DEGREE: preload("res://ui/epilogue/diploma.svg"),
}

@export var text := "Text goes here":
	set(value):
		text = value
		%Label.text = text

@export var type := Type.TIME:
	set(value):
		type = value
		%TextureRect.texture = _ICONS[type]
