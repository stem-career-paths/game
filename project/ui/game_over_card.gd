extends Node2D

var world: World
var _jobs := {
	"science": [
		"Science Job 1",
		"Science Job 2",
		"Science Job 3",
	],
	"technology": [
		"Technology Job 1",
		"Technology Job 2",
		"Technology Job 3",
	],
	"engineering": [
		"Engineering Job 1",
		"Engineering Job 2",
		"Engineering Job 3",
	],
	"mathematics": [
		"Math Job 1",
		"Math Job 2",
		"Math Job 3",
	],
}

@onready var _character_display := %CharacterDisplay
@onready var _job_title_label := %JobTitle


func _ready():
	assert(world!=null, "World must be specified")
	_character_display.character = world.character
	_show_job()


func _show_job() -> void:
	var highest_attributes := _get_highest_attributes()
	var highest_attribute := highest_attributes[randi() % highest_attributes.size()]

	var jobs: Array = _jobs[highest_attribute]
	var job: String = jobs[randi() % jobs.size()]

	_job_title_label.text = job


func _get_highest_attributes() -> Array[String]:
	var character := world.character

	var current_highest: Array[String] = [character.ATTRIBUTE_NAMES[0]]
	var current_highest_value: int = character.get(current_highest[0])

	for i in range(1, 4):
		var attribute: String = character.ATTRIBUTE_NAMES[i]
		var value: int = character.get(attribute)

		if value > current_highest_value:
			current_highest = [attribute]
			current_highest_value = value

		elif value == current_highest_value:
			current_highest.append(attribute)

	return current_highest


func _on_play_again_button_pressed():
	# Naive implementation
	var main_scene: String = ProjectSettings.get_setting("application/run/main_scene")
	get_tree().change_scene_to_file(main_scene)
