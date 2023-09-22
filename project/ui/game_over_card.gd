extends Node2D

var world : World

@onready var _character_display := %CharacterDisplay

func _ready():
	assert(world!=null, "World must be specified")
	_character_display.character = world.character


func _on_play_again_button_pressed():
	# Naive implementation
	var main_scene : String = ProjectSettings.get_setting("application/run/main_scene")
	get_tree().change_scene_to_file(main_scene)
