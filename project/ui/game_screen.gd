## This is the "presenter" of the architecture.
## Its public methods are called by the story model in order to display
## results. Many of the methods are coroutines.
extends Control

signal _option_selected(option: String)
signal tapped_anywhere

const EPILOGUE_CONTROL := preload("res://ui/epilogue/epilogue_phase_control.tscn")

## Seconds until the summary button becomes active
##
## Putting in a delay here prevents a player from accidentally clicking past it
const SUMMARY_DELAY := 3

var world : World:
	set(value):
		world = value
		%CharacterDisplay.character = world.character
		%YearIndicator.set_year(world.year)

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
	
	await _scenario_container.clear()
	
	
	
	_year_indicator.switch_to_text("After high school...")
	
	var generator := preload("res://end/epilogue_text_generator.gd").new()
	var epilogue := Epilogue.create_for(world.character)
	
	if epilogue.gap_year:
		var gap_year := EPILOGUE_CONTROL.instantiate()
		var gap_year_text := generator.generate_gap_year_text(epilogue)
		await _show_epilogue_phase(gap_year)
		await gap_year.play(self, gap_year_text)
	
	if epilogue.community_college:
		var community_college := EPILOGUE_CONTROL.instantiate()
		var community_college_text := generator.generate_community_college_text(epilogue)
		await _show_epilogue_phase(community_college)
		await community_college.play(self, community_college_text)
		
	var university := EPILOGUE_CONTROL.instantiate()
	var university_text := generator.generate_university_text(epilogue)
	await _show_epilogue_phase(university)
	await university.play(self, university_text)
	
	# Only show the postlude if the generator says it has text.
	var postlude_text := generator.generate_postlude_text(epilogue)
	if not postlude_text.is_empty():
		var postlude := EPILOGUE_CONTROL.instantiate()
		await _show_epilogue_phase(postlude)
		await postlude.play(self, postlude_text)
	
	var summary := preload("res://ui/epilogue/epilogue_summary.tscn").instantiate()
	summary.epilogue = epilogue
	await _show_epilogue_phase(summary)

	await show_confirmation("I'm Done!", SUMMARY_DELAY)


func _show_epilogue_phase(control:Control) -> void:
	await %SlidingContentContainer.show_control(control)


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
	scenario. world = world
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


func show_confirmation(message : String, delay := 0):
	assert(delay >= 0)
	var button := _create_option_button(message)
	
	while delay > 0:
		button.disabled = true
		button.text = str(delay)
		await get_tree().create_timer(1).timeout
		delay -= 1
	
	button.text = message
	button.disabled = false
	await button.pressed
	

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
