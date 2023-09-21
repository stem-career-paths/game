class_name SimpleStory extends RefCounted

func run(presenter)->void:
	assert("text" in self, "This story must have 'text'")
	assert("options" in self, "This story must have 'options'")
	
	presenter.show_text(get("text"))
	if "npc_name" in self:
		var npc : Npc = presenter.world.cast.get_by_name(get("npc_name"))
		presenter.show_npc(npc)
	
	var options_dict = get("options")
	var option_keys = options_dict.keys()
	var selected = await presenter.show_options(option_keys)
	presenter.show_text(options_dict[selected].text)
	await presenter.show_effects(options_dict[selected].effects)
	await presenter.show_confirmation()
