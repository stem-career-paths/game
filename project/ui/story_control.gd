## This is the "presenter" of the architecture.
## Its public methods are called by the story model in order to display
## results. Many of the methods are coroutines.
extends Control

signal _option_selected(option: String)
signal _tapped_anywhere

@export var slide_animation_duration := 0.3
@export var slide_animation_ease := Tween.EASE_OUT

var world : World:
	set(value):
		world = value
		%CharacterDisplay.character = world.character
		%YearIndicator.world = world

@onready var _anim_player := $AnimationPlayer
@onready var _advance_anim_player := %AdvanceInstructionsAnimator
@onready var _button_area := %ButtonArea
@onready var _effect_label : Label = %EffectLabel
@onready var _story_label : Label = %StoryLabel
@onready var _npc_panel_container := %NpcPanelContainer
@onready var _top_box_container := %TopBoxContainer
@onready var _top_box := %TopBox

@onready var _max_x : int = ProjectSettings.get_setting("display/window/size/viewport_width")


var _npc_panel : Control

func _ready():
	_anim_player.play("RESET")


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		_tapped_anywhere.emit()


## Finish an interaction with the presenter. 
## This gives the player a chance to confirm that they are done with the
## current story.
##
## This is a coroutine.
func finish() -> void:
	_clear(_button_area)
	
	var button := preload("res://ui/audible_button.tscn").instantiate()
	button.text = "OK"
	_button_area.add_child(button)
	await button.pressed
	
	_clear(_button_area)


## Finish the entire game
func finish_game() -> void:
	var tween_out := create_tween()
	tween_out.tween_property(_top_box, "position", Vector2(-_max_x,0), slide_animation_duration)
	tween_out.set_ease(slide_animation_ease)
	tween_out.tween_callback(func(): _top_box_container.remove_child(_top_box))
	
	var ending_control := preload("res://ui/game_over_control.tscn").instantiate()
	var ending_factory := preload("res://end/ending_factory.gd").new()
	var ending_text := ending_factory.make_ending_story(world)
	ending_control.text = ending_text
	ending_control.position = Vector2(_max_x, 0)
	_top_box_container.add_child(ending_control)
	
	var tween_in := create_tween()\
		.tween_property(ending_control, "position", Vector2.ZERO, slide_animation_duration)\
		.set_ease(slide_animation_ease)
	
	await tween_in.finished
	
	# Right now, there's only one option, so when it's chosen, move on.
	# This will have to be more robust later.
	await show_options(["Play Again"])
	get_tree().change_scene_to_file("res://ui/main_screen.tscn")
	


## Show the player the effects of their decision.
##
## The parameter is a dictionary that maps character attribute names
## to numbers representing the change to that attribute (e.g. +1, -2).
##
## This function does not change the world state: it only shows an animation.
##
## This is a coroutine that returns when the animated effects are complete.
func show_effects(effects: Dictionary) -> void:
	var effect_text := ""
	for attribute in effects.keys():
		effect_text += "%+d %s\n" % [effects[attribute], attribute]
	_effect_label.text = effect_text
	_anim_player.play("show_effect")
	await _anim_player.animation_finished


## Show the portrait of a particular npc.
##
## This is a coroutine that ends with the animation's completion.
func show_npc(npc:Npc) -> void:
	var old_npc_panel := _npc_panel
	if old_npc_panel != null:
		var tween_out := create_tween().set_ease(slide_animation_ease)
		tween_out.tween_property(old_npc_panel, "position", 
			old_npc_panel.position - Vector2(_max_x,0), slide_animation_duration)
		tween_out.tween_callback(func():
			_npc_panel_container.remove_child(old_npc_panel)
		)
	
	_npc_panel = preload("res://ui/npc_panel.tscn").instantiate()
	_npc_panel.npc = npc
	_npc_panel.position.x = _max_x
	_npc_panel_container.add_child(_npc_panel)
	# Be careful to put the new child _beneath_ the advance instructions control.
	# This makes sure the "tap to advance" instruction shows over it.
	_npc_panel_container.move_child(_npc_panel, 0)
	
	var tween_in := create_tween().set_ease(slide_animation_ease)
	tween_in.tween_property(_npc_panel, "position", Vector2.ZERO, slide_animation_duration)
	await tween_in.finished


## Show options to the player and await for them to select one.
## The selected option is returned.
func show_options(options: Array) -> String:
	var buttons : Array[Control] = []
	for option in options:
		var button := preload("res://ui/audible_button.tscn").instantiate()
		button.text = option
		button.pressed.connect(func(): _option_selected.emit(option))
		_button_area.add_child(button)
		buttons.append(button)

	var selection = await _option_selected

	for button in buttons:
		button.disabled = true

	return selection


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
				_advance_anim_player.play("show_advance_instructions")
				await _tapped_anywhere
				_advance_anim_player.stop()
				_advance_anim_player.play("RESET")

	else:
		push_error("Unexpected parameter type: " + story.get_class())


## Remove all the children from the given container.
func _clear(container:Control) -> void:
	while container.get_child_count() > 0:
		container.remove_child(container.get_child(0))
