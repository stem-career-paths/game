class_name DistributionCalculator
extends RefCounted

var story_loader := StoryLoader.new()


## Calculate the distribution of all stories combined
func calculate() -> Distribution:
	return Distribution.combine(calculate_all_stories())


## Calculate the distribution of all stories in the game
func calculate_all_stories() -> Array[Distribution]:
	return calculate_stories(StoryLoader.STORY_PATH)


## Calculate the distribution of all stories in a directory
func calculate_stories(path: String) -> Array[Distribution]:
	var story_paths := story_loader.get_simple_story_paths_in_directory(path)

	var result: Array[Distribution] = []

	# This is needed to allow the type hint for the array.
	# https://github.com/godotengine/godot/issues/72566#issuecomment-1413229460
	result.assign(story_paths.map(calculate_story))

	return result


## Calculate the distribution of a single story
func calculate_story(file_path: String) -> Distribution:
	var story := story_loader.load_simple_story(file_path)

	var distribution := Distribution.new()

	if not story:
		return distribution

	if not story.npc_name in distribution.npcs:
		distribution.npcs[story.npc_name] = 0

	distribution.npcs[story.npc_name] += 1

	for option in story.options.values():
		if not "effects" in option:
			continue

		for effect in option.effects.keys():
			distribution.attributes[effect] += option.effects[effect]

	return distribution


class Distribution:
	var npcs := {}
	var attributes := {}

	func _init():
		for attribute in Character.ATTRIBUTE_NAMES:
			attributes[attribute] = 0


	static func combine(distributions: Array[Distribution]) -> Distribution:
		return Distribution.new().merge_all(distributions)


	func merge(other: Distribution) -> Distribution:
		for npc in other.npcs.keys():
			if not npc in npcs:
				npcs[npc] = 0

			npcs[npc] += other.npcs[npc]

		for attribute in Character.ATTRIBUTE_NAMES:
			attributes[attribute] += other.attributes[attribute]

		return self


	func merge_all(distributions: Array[Distribution]) -> Distribution:
		for distribution in distributions:
			merge(distribution)

		return self


	func _to_string():
		var result: Array[String] = []

		result.append("NPCs:")
		for npc in npcs.keys():
			result.append("    %s: %d" % [npc, npcs[npc]])

		result.append("\nAttributes:")
		for attribute in Character.ATTRIBUTE_NAMES:
			result.append("    %s: %d" % [attribute, attributes[attribute]])

		return "\n".join(result)
