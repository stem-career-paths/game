extends Control

signal _option_selected(option: String)

enum _EntranceType { FIXED, ANIMATED }

@export_file("*.gd") var initial_story 
@export var slide_in_duration := 0.35

var world := World.new()
var _max_x := 750

var _current_card : Node

func _ready():
	assert(initial_story!=null)
	var story = load(initial_story).new()
	await _show_card(story, _EntranceType.FIXED)
	
	var next = load("res://story/steven_dnd.gd").new()
	await _show_card(next, _EntranceType.ANIMATED)


func _show_card(story : Object, entrance : _EntranceType) -> void:
	var presenter := preload("res://card/story_card.tscn").instantiate()
	presenter.world = world
	
	if entrance == _EntranceType.ANIMATED:
		presenter.position.x = _max_x
	
	add_child(presenter)
	
	if entrance == _EntranceType.ANIMATED:
		var tween := get_tree().create_tween()
		var previous_card = _current_card
		tween.tween_property(presenter, "position", Vector2.ZERO, slide_in_duration)\
			.set_ease(Tween.EASE_IN)
		# Remove the card in the background once it is covered up
		tween.tween_callback(func(): 
			if previous_card != null:
				remove_child(previous_card)
		)

	_current_card = presenter
	await story.run(presenter)
