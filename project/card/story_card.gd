## This is the "presenter" of the architecture.
## Its public methods are called by the story model in order to display
## results. Many of the methods are coroutines.
extends Control

var world : World:
	set(value):
		world = value
		%CharacterDisplay.character = world.character

signal _option_selected(option: String)
signal _tapped_anywhere


@onready var _anim_player := $AnimationPlayer
@onready var _button_area := %ButtonArea
@onready var _effect_label : Label = %EffectLabel
@onready var _main_image : TextureRect = %MainImage
@onready var _character_name_label: Label = %CharacterName
@onready var _story_label : Label = %StoryLabel

func _ready():
	assert(world!=null)
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
	_anim_player.play("show_advance_instructions")
	await _tapped_anywhere


## Show the player the effects of their decision.
##
## The parameter is a dictionary that maps character attribute names
## to numbers representing the change to that attribute (e.g. +1, -2).
##
## This is a coroutine that returns when the animationed effects are complete.
func show_effects(effects: Dictionary) -> void:
	var effect_text := ""
	for attribute in effects.keys():
		world.character[attribute] += effects[attribute]
		effect_text += "%+d %s\n" % [effects[attribute], attribute]
	_effect_label.text = effect_text
	_anim_player.play("show_effect")
	await _anim_player.animation_finished


## Show the portrait of a particular npc.
func show_npc(npc:Npc) -> void:
	_character_name_label.text = npc.name
	_main_image.texture = npc.image


## Show options to the player and await for them to select one.
## The selected option is returned.
func show_options(options: Array) -> String:
	var buttons : Array[Button] = []
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
func show_text(text: String) -> void:
	_story_label.text = text


## Remove all the children from the given container.
func _clear(container:Control) -> void:
	while container.get_child_count() > 0:
		container.remove_child(container.get_child(0))
