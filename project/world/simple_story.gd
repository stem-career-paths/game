class_name SimpleStory extends RefCounted

## The name of the function that can be called when an option is selected,
## if it exists.
const _ON_OPTION_SELECTED_NAME := "on_option_selected"


func run(presenter) -> void:
	assert("text" in self, "This story must have 'text'")
	assert(get("text") is String or get("text") is Array, "The 'text' must be a string or an array")
	assert("options" in self, "This story must have 'options'")

	# Clear any old text from the screen first
	presenter.show_text("")

	# If the npc is specified, load it, and if not, pick one at random.
	var npc : Npc
	if "npc_name" in self:
		npc = presenter.world.cast.get_by_name(get("npc_name"))
	else:
		npc = presenter.world.cast.pick_random()
	await presenter.show_npc(npc)

	# Show the introductory text
	var intro_text = get("text") # Can be String or Array[String].
	await presenter.show_text(intro_text)

	# Show the player their options and wait for them to select one.
	var options_dict = get("options")
	var option_keys = options_dict.keys()
	var selected = await presenter.show_options(option_keys)

	# Use the subclass' callback method if it has one.
	if self.has_method(_ON_OPTION_SELECTED_NAME):
		call(_ON_OPTION_SELECTED_NAME, selected, presenter.world)

	# Extract the parts of the result.
	var result = options_dict[selected]
	var conclusion = result.text
	var effects = result.effects if "effects" in result else null

	# Show the conclusion of this vignette
	await presenter.show_text(conclusion)
	await presenter.show_continue()
	
	# Clear the text before showing the effect animation
	presenter.show_text("")
	
	# Show and then apply the attribute changes if there are any
	if effects is Dictionary:
		await presenter.show_effects(effects)
		_apply_effects(effects, presenter.world)

	# Wait for the player to wrap up the interaction (e.g. click "OK")
	await presenter.finish()

	# If this interaction resulted in a new end story, track it in the world.
	if "end_story" in result:
		var new_ending_possibility :String = result.end_story
		presenter.world.end_stories.append(new_ending_possibility)


func _apply_effects(effects:Dictionary, world:World) -> void:
	for attribute_name in effects.keys():
		world.character[attribute_name].value += effects[attribute_name]
