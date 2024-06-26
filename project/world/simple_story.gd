class_name SimpleStory extends RefCounted

## The name of the function that can be called when an option is selected,
## if it exists.
const _ON_OPTION_SELECTED_NAME := "on_option_selected"


func run(presenter) -> void:
	assert("text" in self, "This story must have 'text'")
	assert(get("text") is String or get("text") is Array, "The 'text' must be a string or an array")
	assert("npc_name" in self, "This story must have 'npc_name'")
	assert("options" in self, "This story must have 'options'")

	# Clear any old text from the screen first
	presenter.show_text("")

	var npc : Npc = presenter.world.cast.get_by_name(get("npc_name"))

	# If the location is specified, load it, and if not, pick one at random.
	var location : Texture
	if "location" in self:
		location = presenter.world.game_map.get_by_name(get("location"))
	else:
		location = presenter.world.game_map.pick_random()
	await presenter.show_npc(npc, location)

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
	var tag = result.tags if "tags" in result else null

	# Show the conclusion of this vignette
	await presenter.show_text(conclusion)

	# Make the change to the model
	if effects != null:
		_apply_effects(effects, presenter.world)
	
	# Apply Tag 
	if tag != null:
		presenter.world.character.add_tag(tag)
		

	# If there are attribute changes, visualize them
	var handle : AnimationHandle
	if effects is Dictionary:
		await presenter.show_continue()
		# Clear the text before showing the effect animation
		presenter.show_text("")
		
		# Don't actually wait for the effects to finish.
		# This would stop the player from being able to skip through it.
		handle = presenter.show_effects(effects)

	# Wait for the player to wrap up the interaction (e.g. click "OK")
	await presenter.finish()
	
	# If there was an animation running, stop it.
	if handle != null:
		handle.stop_animation()


## Determine if this story is able to be selected now,
## given the world state.
func is_active(world: World) -> bool:
	if "years" in self and not get("years").has(world.year):
		return false

	return true


func _apply_effects(effects:Dictionary, world:World) -> void:
	for attribute_name in effects.keys():
		world.character[attribute_name].value += effects[attribute_name]
