class_name StoryCardParser extends RefCounted

func parse(text:String)->StoryCard:
	var json := JSON.new()
	var parse_result = json.parse(text)
	assert(parse_result==OK, "Parsing JSON text failed.\nError \"%s\" on line %d." % [json.get_error_message(), json.get_error_line()])
	
	var result := StoryCard.new()
	result.text = json.data["text"]
	
	var options_array = json.data["options"]
	for option_dict in options_array:
		var option := StoryOption.new()
		option.text = option_dict["name"]
		var effects_dict = option_dict["effects"]
		for effect_key in effects_dict.keys():
			var effect := StoryEffect.new()
			effect.attribute_name = effect_key
			effect.value = int(effects_dict[effect_key])
			option.effects.append(effect)
		result.options.append(option)
	
	return result
