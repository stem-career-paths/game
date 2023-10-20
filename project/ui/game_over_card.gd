extends Control

## Path to the factory class that generates ending stories.
@export_file("*.gd") var ending_factory := "res://end/ending_factory.gd"

var world: World

@onready var _character_display := %CharacterDisplay
@onready var _result_label := %ResultLabel


func _ready():
	assert(world != null, "World must be specified")
	_character_display.character = world.character
	
	var factory = load(ending_factory).new()
	var ending_story : String = factory.make_ending_story(world)
	_result_label.text = ending_story


func _on_play_again_button_pressed():
	# Naive implementation
	var main_scene: String = ProjectSettings.get_setting("application/run/main_scene")
	get_tree().change_scene_to_file(main_scene)
