class_name SimpleStory extends RefCounted


func run(presenter) -> void:
	assert("text" in self, "This story must have 'text'")
	assert(get("text") is String or get("text") is Array, "The 'text' must be a string or an array")
	assert("options" in self, "This story must have 'options'")

	if "npc_name" in self:
		var npc: Npc = presenter.world.cast.get_by_name(get("npc_name"))
		presenter.show_npc(npc)

	await _show(presenter, get("text"), get("effects"))

	var options_dict = get("options")
	var option_keys = options_dict.keys()
	var selected = await presenter.show_options(option_keys)

	await _show(presenter, options_dict[selected].text, options_dict[selected].effects)

	await presenter.show_confirmation()


func _show(presenter, text, effects = null):
	if text is String:
		presenter.show_text(text)
	else:
		presenter.show_text(text[0])

	if effects is Dictionary:
		await presenter.show_effects(effects)

	if text is Array:
		for line in text.slice(1):
			await presenter.show_confirmation()
			presenter.show_text(line)
