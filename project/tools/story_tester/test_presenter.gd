extends RefCounted


var _effects := {}
var _depth := 0
var _phase := []
var _show_options_ran := false


func test(story_path: String) -> Dictionary:
	_effects = {}
	_phase = [0]

	while not _phase.is_empty():
		var story = load(story_path).new()

		_show_options_ran = false
		_depth = 0

		story.run(self)

		if not _show_options_ran:
			break

		while not _phase.is_empty() and _phase[_phase.size() - 1] == -1:
			_phase.pop_back()

		if not _phase.is_empty():
			_phase[_phase.size() - 1] += 1
	
	return _effects


func finish(_text := "OK") -> void:
	pass


func show_effects(effects: Dictionary) -> void:
	for effect in effects.keys():
		if effect not in _effects.keys():
			_effects[effect] = 0

		_effects[effect] += effects[effect]


func show_options(options: Array) -> String:
	if _depth >= _phase.size():
		_phase.append(0)

	var choice = _phase[_depth]

	if choice + 1 >= options.size():
		_phase[_depth] = -1

	_depth += 1

	_show_options_ran = true
	return options[choice]


func show_text(_text: String) -> void:
	pass
