## This is the "presenter" of the architecture.
## Its public methods are called by the story model in order to display
## results. Many of the methods are coroutines.
extends Control

signal _option_selected(option: String)
signal tapped_anywhere

var world : World:
	set(value):
		world = value
		%CharacterDisplay.character = world.character
		%YearIndicator.set_year(world.year)

## This box holds the whole top interaction area. It is the container
## whose content is swapped out by the ending screen at the end of
## the game, which allows the bottom to stay in place.
@onready var _top_container := %TopContainer
@onready var _option_area := %OptionArea
@onready var _story_label : AnimatedLabel = %StoryLabel
@onready var _year_indicator := %YearIndicator
@onready var _scenario_container := %ScenarioContainer
@onready var _animation_player := $AnimationPlayer
@onready var _attribute_change_label := %AttributeChangeLabel

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		tapped_anywhere.emit()


## Return the respective line count of each option button text.
##
## This is used for integration testing and is not intended to be
## part of the presenter layer.
func get_visible_line_counts_in_options() -> Array[int]:
	var result : Array[int] = []
	for button in _option_area.get_children():
		result.append(button.get_visible_line_count())
	return result


## Finish an interaction with the presenter. 
## This gives the player a chance to confirm that they are done with the
## current story.
##
## This is a coroutine.
func finish() -> void:
	_clear(_option_area)
	
	var button := preload("res://ui/audible_button.tscn").instantiate()
	button.text = "OK"
	_option_area.add_child(button)
	await button.pressed
	
	_clear(_option_area)


## Finish the entire game
func finish_game() -> void:
	# Track the completion of a game on Google Analytics
	if OS.get_name() == "Web":
		JavaScriptBridge.eval("""
		  gtag("event", "level_end", {
				"level_name": "Regular Game"
			});
		""")
	
	var ending_control := preload("res://ui/game_over_control.tscn").instantiate()
	var ending_factory := preload("res://end/ending_factory.gd").new()
	var ending := ending_factory.make_ending_story(world)
	ending_control.major = ending.major
	ending_control.text = ending.text
	
	await _scenario_container.clear()
	
	_clear(_top_container)
	# Simply hiding the year indicator is not a great UI. Animating
	# between states might be better, but as of this writing, we don't
	# have a clear design for how it should go away.
	_year_indicator.visible = false
	_top_container.add_child(ending_control)

	# Wait for the animation to finish before showing the options.
	ending_control.play()
	await ending_control.animation_finished

	# Right now, there's only one option, so when it's chosen, move on.
	# This will have to be more robust later.
	await show_options(["Play Again"])


## Show the player the effects of their decision.
##
## The parameter is a dictionary that maps character attribute names
## to numbers representing the change to that attribute (e.g. +1, -2).
##
## This function does not change the world state: it only shows an animation.
##
## This is not a coroutine. It returns an animation handle.
func show_effects(_effects: Dictionary) -> AnimationHandle:
	# Assemble the text
	var text := ""
	for attribute_name in _effects.keys():
		text += "%s +%d\n" % [attribute_name.to_pascal_case(), _effects[attribute_name]]
	_attribute_change_label.text = text
	
	# Play the animation
	_animation_player.play("attribute_change")
	var handle := AnimationHandle.new(_animation_player)
	# If someone stops the animation, make sure the character display is still updated.
	handle.stopped.connect(func():
		%CharacterDisplay.update_smoothly()
	)
	
	return handle


## Show the portrait of a particular npc.
##
## This is a coroutine that ends with the animation's completion.
func show_npc(npc:Npc, location:Texture) -> void:
	var scenario := preload("res://ui/scenario_view.tscn").instantiate()
	scenario.npc = npc
	scenario.location = location
	await _scenario_container.show_control(scenario)


## Show options to the player and await for them to select one.
## The selected option is returned.
func show_options(options: Array) -> String:
	var buttons : Array[Control] = []
	for option in options:
		buttons.append(_create_option_button(option))

	var selection = await _option_selected
	GameLog.made_choice(selection)

	for button in buttons:
		button.disabled = true

	return selection


func _create_option_button(option: String) -> Node:
	var button := preload("res://ui/audible_button.tscn").instantiate()
	button.text = option
	button.pressed.connect(func(): _option_selected.emit(option))
	_option_area.add_child(button)
	
	return button


## Show the "continue" message to the player and wait for them to press it.
##
## This is a coroutine that waits until the button has been pressed.
func show_continue(prompt := "Continue") -> void:
	_clear(_option_area)
	await show_options([prompt])
	_clear(_option_area)


## Show text in the main message area.
##
## The parameter may be a String or an Array[String].
##
## This is a coroutine that returns when the text (or the last page of text)
## has been shown.
func show_text(story) -> void:
	if story is String:
		_story_label.text = story
		
	elif story is Array:
		for i in story.size():
			var substory : String = story[i]
			_story_label.text = substory
			
			# If this is not the last substory, let the player click through.
			if i < story.size()-1:
				_clear(_option_area)
				await show_continue()
				_clear(_option_area)
				

	else:
		push_error("Unexpected parameter type: " + story.get_class())


## Advance the year to the given value.
##
## This is a coroutine that completes when the animation is done.
func show_year_advancement(new_year:Year.Name) -> void:
	%YearIndicator.show_advancement(new_year)
	
	# Clear any remaining text
	_story_label.text = ""
	
	# If there are children, clear them out.
	# There may not be children on the first call, for the
	# announcement of "Freshman Year."
	if %ScenarioContainer.get_child_count() > 0:
		await %ScenarioContainer.clear()
	
	var label := preload("res://ui/year_change_label.tscn").instantiate()
	label.year = new_year
	await %ScenarioContainer.show_control(label)
	await show_continue("I'm ready!")
	await %ScenarioContainer.clear()
	label.queue_free()


## Remove all the children from the given container.
func _clear(container:Control) -> void:
	while container.get_child_count() > 0:
		container.remove_child(container.get_child(0))
