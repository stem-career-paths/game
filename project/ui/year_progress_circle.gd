class_name ProgressCircle
extends Control

@export var outer_circle_radius := 10
@export var inner_border := 2


@export var year_passed : bool:
	set(value):
		year_passed = value
		queue_redraw()


func _draw() -> void:
	draw_circle(Vector2.ZERO, outer_circle_radius, Palette.LIGHT_BLUE)
	if year_passed:
		draw_circle(Vector2.ZERO, outer_circle_radius-inner_border, Palette.BLUE)
