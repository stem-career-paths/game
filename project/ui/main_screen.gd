extends Control

var world := World.new()

signal _option_selected(option: String)


func _ready():
	%CharacterDisplay.character = world.character
	var story := preload("res://story/meta_story.gd").new()
	await story.run(self)
	print("Story is done")


func _clear_story_area():
	for child in %StoryArea.get_children():
		child.queue_free()


## PRESENTER METHODS ------------------------------------


func show_confirmation(text := "OK") -> void:
	var button := Button.new()
	button.text = text
	%StoryArea.add_child(button)
	await button.pressed

	_clear_story_area()


func show_effects(effects: Dictionary) -> void:
	for attribute in effects.keys():
		world.character[attribute] += effects[attribute]


func show_options(options: Array) -> String:
	for option in options:
		var button := Button.new()
		button.text = option
		button.pressed.connect(func(): _option_selected.emit(option))
		%StoryArea.add_child(button)

	var selection = await _option_selected
	print("Going to return ", selection)

	_clear_story_area()

	return selection


func show_text(text: String) -> void:
	%Text.text = "[center]%s" % text


func show_image(image: String) -> void:
	%Image.texture = load("res://images/%s.png" % image)
