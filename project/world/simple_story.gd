class_name SimpleStory extends RefCounted

## The name of the function that can be called when an option is selected,
## if it exists.
const _ON_OPTION_SELECTED_NAME := "on_option_selected"


func run(presenter) -> void:
	assert("text" in self, "This story must have 'text'")
	assert(get("text") is String or get("text") is Array, "The 'text' must be a string or an array")
	assert("options" in self, "This story must have 'options'")

	# If the npc is specified, load it, and if not, pick one at random.
	var npc : Npc
	if "npc_name" in self:
		npc = presenter.world.cast.get_by_name(get("npc_name"))
	else:
		npc = presenter.world.cast.pick_random()
	presenter.show_npc(npc)

	await _show(presenter, get("text"), get("effects"))

	var options_dict = get("options")
	var option_keys = options_dict.keys()
	var selected = await presenter.show_options(option_keys)

	if self.has_method(_ON_OPTION_SELECTED_NAME):
		call(_ON_OPTION_SELECTED_NAME, selected, presenter.world)

	var result = options_dict[selected]
	var selected_text = result.text
	var selected_end_story = result.end_story if "end_story" in result else null
	var selected_effects = result.effects if "effects" in result else null

	await _show(presenter, selected_text, selected_effects)
	if selected_end_story is String:
		_add_end_story(selected_end_story, presenter.world)
	if selected_effects is Dictionary:
		_apply_effects(selected_effects, presenter.world)

	await presenter.finish()


func _show(presenter, text, effects = null):
	await presenter.show_text(text)

	if effects is Dictionary:
		await presenter.show_effects(effects)


func _add_end_story(end_story: String, world: World) -> void:
	world.end_stories.append(end_story)


func _apply_effects(effects:Dictionary, world:World) -> void:
	for attribute_name in effects.keys():
		world.character[attribute_name].value += effects[attribute_name]
