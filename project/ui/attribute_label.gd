extends Control

enum Style {
	REGULAR,
	LARGE
}

@export var text : String:
	set(value):
		text = value
		%Label.text = value

@export var animation_duration := 0.3

@export var style : Style

var attribute : Attribute:
	set(value):
		assert(value!=null, "Attribute may not be null")
		assert(attribute==null, "Attribute may only be specified once")
		attribute = value


func _ready():
	if style==Style.LARGE:
		var label : Label = %Label
		label.set("theme_override_font_sizes/font_size", 64) 
		label.set("theme_override_fonts/font", preload("res://ui/attribute_large_font_style.tres"))
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func update_smoothly() -> void:
		create_tween()\
			.tween_property(%ProgressBar, "ratio", attribute.get_ratio(), animation_duration)\
			.set_ease(Tween.EASE_IN)


func update_instantly() -> void:
	%ProgressBar.ratio = attribute.get_ratio()
