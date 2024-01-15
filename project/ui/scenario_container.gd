extends Control

@export var ui_placeholder : Control

@export var duration := 0.5

func _ready():
	if ui_placeholder==null:
		push_warning("No placeholder connected. Cannot determine size of scenario view.")
	else:
		# Set the size to whatever the placeholder is, which has to be laid out
		# before we can get its laid-out size.
		ui_placeholder.item_rect_changed.connect(_update_scenario_position)
		
		# Update position when the viewport changes (e.g. window resized)
		get_viewport().size_changed.connect(_update_scenario_position)


func _update_scenario_position() -> void:
	var destination := ui_placeholder.get_global_rect().position
	global_position = destination

## Remove the content from this container.
##
## It will animate away.
##
## This is a coroutine that completes when its animation is done.
func clear() -> void:
	if get_child_count() == 0:
		push_warning("There are no children here. Clear should not have been called.")
	else:
		await _animate_child_out()


func _animate_child_out() -> void:
	var child := get_child(0)
	var tween_out := _create_configured_tween()
	tween_out.tween_property(child, "position:x", -size.x, duration)
	tween_out.tween_property(child, "modulate:a", 0, duration)
	tween_out.finished.connect(func():
		remove_child(child)
	)
	await tween_out.finished


func _animate_child_in(control:Control)->void:
	add_child(control)
	control.position.x = size.x
	control.modulate.a = 0
	var tween_in := _create_configured_tween()
	tween_in.tween_property(control, "position:x", 0, duration)
	tween_in.tween_property(control, "modulate:a", 1, duration)
	await tween_in.finished


## Show the given control.
##
## If there is already one control showed by this container, it will be animated
## out and the new one shown.
##
## This is a coroutine that completes when its animation is done
func show_control(control:Control) -> void:
	if get_child_count() == 0:
		await _animate_child_in(control)
	else:
		_animate_child_out()
		await _animate_child_in(control)
		

func _create_configured_tween() -> Tween:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)
	return tween
